-- Bootstrap lazy.nvim
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- this starts lazy.nvim
-- which imports the 'plugins' folder
require("config.lazy")
require("keymaps")
