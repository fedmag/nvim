return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  enabled = not vim.g.vscode,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set('n', '<leader>fG', builtin.grep_string, { desc = "Telescope grep word under cursor" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Telescope resume last search" })

    -- this is needed to grab the current selected text so that it can be used to grep that text
    function vim.getVisualSelection()
      local current_clipboard_content = vim.fn.getreg('"')

      vim.cmd('noau normal! "vy"')
      local text = vim.fn.getreg('v')
      vim.fn.setreg('v', {})

      vim.fn.setreg('"', current_clipboard_content)

      text = string.gsub(text, "\n", "")
      if #text > 0 then
        return text
      else
        return ''
      end
    end

    -- call grep string with the grabbed text
    vim.keymap.set('v', '<space>fG', function()
      local text = vim.getVisualSelection()
      builtin.grep_string({ search = text })
    end)
  end,
}
