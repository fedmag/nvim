-- Bootstrap lazy.nvim
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")

-- sessions
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- default border, for signature help noice.lua is responsible
vim.o.winborder = 'rounded'
-- this starts lazy.nvim
-- which imports the 'plugins' folder
require("config.lazy")
require("keymaps")
