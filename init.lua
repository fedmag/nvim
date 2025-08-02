-- Bootstrap lazy.nvim
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")

local opt = vim.opt
-- sessions
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- default border, for signature help noice.lua is responsible
opt.winborder = 'rounded'

opt.listchars = { trail = '·', nbsp = '␣' }

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- share clipboard with OS
opt.clipboard = "unnamedplus"

-- show cursorline
opt.cursorline = true
opt.cursorlineopt = 'screenline'
opt.cursorcolumn = false

-- start to scroll n lines before the bottom
-- helps keeping the cursor more centered on the screen
-- during scrolling
opt.scrolloff = 10

-- indent
opt.autoindent = true
opt.copyindent = true
opt.breakindent = true

-- disable swapfile
opt.swapfile = false

-- Enable undofiles
opt.undofile = true
vim.o.undodir = vim.fs.normalize('~/.cache')
--test

-- Enable auto write
opt.autowriteall = true
--
--test
-- this starts lazy.nvim
-- which imports the 'plugins' folder
require("config.lazy")
require("keymaps")

if vim.g.vscode then
  vim.cmdheight = 1
  return
end
