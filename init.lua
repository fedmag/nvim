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

vim.opt.listchars = { trail = '·', nbsp = '␣' }
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- share clipboard with OS
vim.opt.clipboard = "unnamedplus"

-- this starts lazy.nvim
-- which imports the 'plugins' folder
require("config.lazy")
require("keymaps")

if vim.g.vscode then
  vim.cmdheight = 1
  return
end
