package fedmag.gptandem.controller;

import fedmag.gptandem.services.helper.ChatHistory;
import fedmag.gptandem.services.helper.Languages;
import fedmag.gptandem.services.helper.Message;
import fedmag.gptandem.services.openai.ChatGPT;
import fedmag.gptandem.services.openai.Tandem;
import fedmag.gptandem.services.speech2text.GoogleSpeechToText;
import fedmag.gptandem.services.speech2text.MicrophoneRecorder;
import fedmag.gptandem.services.speech2text.MicrophoneService;
import fedmag.gptandem.services.speech2text.Transcriber;
import fedmag.gptandem.services.text2speech.GoogleTextToSpeech;
import fedmag.gptandem.services.text2speech.Speaker;
import fedmag.gptandem.ui.UI;
import lombok.extern.slf4j.Slf4j;
import javax.swing.*;

@Slf4j
public class Controller {

    private final UI ui;
    private final Transcriber speech2text;
    private final MicrophoneRecorder microphoneService;
    private final ChatHistory chatHistory;
    private Languages sessionLanguage;
    private final Tandem tandem;
    private final Speaker speaker;


    public Controller(Languages language) {
        // TODO maybe we could even make all these parameters in the main?
        this.sessionLanguage = language;
        this.ui = new UI();
        this.speech2text = new GoogleSpeechToText();
        this.microphoneService = new MicrophoneService();
        this.chatHistory = new ChatHistory();
        chatHistory.addMessage(new Message(
                "system",
                "you are an helpful tandem partner that is helping me learning " + language.getLongLanguageName() + ". My current level is A2 and you will reply in such a language."));
        this.tandem = new ChatGPT();
        this.speaker = new GoogleTextToSpeech();

        initController();
    }

    void setSessionLanguage(Languages newLanguage) {this.sessionLanguage = newLanguage;} // TODO need a dropdown to select the language, probably the controller should not encapsulate this logic but should be demanded to the individual components.

    public void initController() {
        ui.setStateAreaText("Press \"Record\" when ready!");
        ui.setSendButtonActive(false);
        ui.setRepeatLastButtonActive(false);

        ui.setRecordButtonListener(e -> {
            log.info("Record button pressed");
            ui.setSendButtonActive(false);
            ui.setRepeatLastButtonActive(false);

            if (microphoneService.isRecording()) {
                microphoneService.stopRecording();
            } else {
                ui.setRecordButtonText("Stop");
                SwingWorker<Void, Void> worker = new SwingWorker<>() {
                    @Override
                    protected Void doInBackground() throws Exception {
                        // Perform the long-lasting process here
                        // This will execute in the background thread
                        ui.setStateAreaText("Recording..");
                        ui.setRepeatLastButtonActive(false);
                        microphoneService.startRecording();
                        return null;
                    }

                    @Override
                    protected void done() {
                        // Executed on the EDT after the doInBackground() method completes
                        // Update the UI or perform any necessary post-processing
                        ui.setStateAreaText("Record captured!");
                        ui.setRecordButtonText("Record");
                        ui.setSendButtonActive(true);
                    }
                };
                worker.execute();
            }
        });

        ui.setSendButtonListener(e -> {
            log.info("Send button pressed");
            ui.setRecordButtonActive(false);
            ui.setSendButtonActive(false);
            ui.setRepeatLastButtonActive(false);
            // send to OpenAI
            startTranscriptionTask();
        });

        ui.setRepeatLastButtonListener(e -> {
            log.info("Repeating last sentence..");
            startRepeatTask();
        });
    }

    private void startTranscriptionTask() {
        SwingWorker<Void, Void> transcribeWorker = new SwingWorker<>() {
            @Override
            protected Void doInBackground() {
                ui.setStateAreaText("Transcribing..");
                ui.setRepeatLastButtonActive(false);
                speech2text.transcribe(microphoneService.getLastRecording(), sessionLanguage);
                return null;
            }

            @Override
            protected void done() {
                chatHistory.addMessage(new Message("user", speech2text.getLastTranscription()));
                // TODO maybe I want to pass the string directly?
                ui.displayChatHistory(chatHistory);
                startReplyTask();
            }
        };
        transcribeWorker.execute();
    }

    private void startReplyTask() {
        SwingWorker<Void, Void> aiWorker = new SwingWorker<>() {
            @Override
            protected Void doInBackground() {
                // Perform the long-lasting process here
                // This will execute in the background thread
                ui.setStateAreaText("Waiting for response..");
                ui.setRepeatLastButtonActive(false);
                tandem.reply(chatHistory);
                return null;
            }

            @Override
            protected void done() {
                // Executed on the EDT after the doInBackground() method completes
                // Update the UI or perform any necessary post-processing
                ui.setStateAreaText("Reply captured!");
                chatHistory.addMessage(new Message("assistant", tandem.getLastReply()));
                ui.displayChatHistory(chatHistory);
                startSpeakTask();
            }
        };
        aiWorker.execute();
    }

    private void startSpeakTask() {
        SwingWorker<Void, Void> worker = new SwingWorker<>() {
            @Override
            protected Void doInBackground() {
                // Perform the long-lasting process here
                // This will execute in the background thread
                ui.setStateAreaText("Speaking...");
                ui.setRepeatLastButtonActive(false);
                speaker.speak(tandem.getLastReply(), sessionLanguage);
                return null;
            }

            @Override
            protected void done() {
                // Executed on the EDT after the doInBackground() method completes
                // Update the UI or perform any necessary post-processing
                ui.setStateAreaText("Waiting for new inputs!");
                ui.setRecordButtonActive(true);
                ui.setRepeatLastButtonActive(true);
            }
        };
        worker.execute();
    }

    private void startRepeatTask() {
        SwingWorker<Void, Void> worker = new SwingWorker<>() {
            @Override
            protected Void doInBackground() {
                // Perform the long-lasting process here
                // This will execute in the background thread
                ui.setStateAreaText("Repeating...");
                ui.setSendButtonActive(false);
                ui.setRepeatLastButtonActive(false);
                speaker.repeatLast();
                return null;
            }

            @Override
            protected void done() {
                // Executed on the EDT after the doInBackground() method completes
                // Update the UI or perform any necessary post-processing
                ui.setStateAreaText("Waiting for new inputs!");
                ui.setRepeatLastButtonActive(true);
                ui.setRecordButtonActive(true);
            }
        };
        worker.execute();
    }
}