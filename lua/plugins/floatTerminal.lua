return {
  "voldikss/vim-floaterm",
  config = function()
    vim.keymap.set({ "n", "i", "t" }, "<leader>tt", "<Cmd>FloatermToggle<cr>")
    vim.keymap.set({ "n", "i", "t" }, "<leader>tk", "<Cmd>FloatermKill<cr>")
  end,
}
