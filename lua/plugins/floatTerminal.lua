return {
  "voldikss/vim-floaterm",
  enable = not vim.g.vscode,
  config = function()
    vim.keymap.set({ "n", "i", "t" }, "<leader>tt", "<Cmd>FloatermToggle<cr>")
    vim.keymap.set({ "n", "i", "t" }, "<leader>tk", "<Cmd>FloatermKill<cr>")
  end,
}
