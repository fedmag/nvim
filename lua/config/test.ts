const configService = {}

const globalPrefix = configService.get("app", { infer: true})

if (globalPrefix.length() >= 45) {

  console.log("this is an error")
} else {
  console.error("this was not")
}

let x = 45

x = x+45

app.enableCors(
  {
    credentials: true,
    mehtods: ["GET"]
    maxAge: 3600
  }
)

