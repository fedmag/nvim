-- ============================================================================
-- OPTIONS
-- ============================================================================
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.cursorline = true  -- highlight current line
vim.opt.wrap = false       -- do not wrap lines by default
vim.opt.scrolloff = 10     -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10 -- keep 10 lines to left/right of cursor
vim.opt.cursorcolumn = false
vim.opt.wrap = false

-- tabs
vim.opt.tabstop = 2        -- tabwidth
vim.opt.shiftwidth = 2     -- indent width
vim.opt.softtabstop = 2    -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true   -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true  -- copy indent from current line

-- search
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true  -- case sensitive if uppercase in string
vim.opt.hlsearch = true   -- highlight search matches
vim.opt.incsearch = true  -- show matches as you type

-- undo
local undodir = vim.fn.expand("~/.vim/undodir")
if
    vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
  vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false      -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false    -- do not create a swapfile
vim.opt.undofile = true     -- do create an undo file
vim.opt.undodir = undodir   -- set the undo directory
vim.opt.updatetime = 300    -- faster completion
vim.opt.timeoutlen = 500    -- timeout duration
vim.opt.ttimeoutlen = 0     -- key code timeout
vim.opt.autoread = true     -- auto-reload changes if outside of neovim

-- other
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.undofile = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.colorcolumn = "100"                       -- show a column at 100 position chars
vim.opt.showmatch = true                          -- highlights matching brackets
vim.opt.cmdheight = 1                             -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.iskeyword:append("-")                     -- include - in words
vim.opt.path:append("**")                         -- include subdirs in search
vim.opt.selection = "inclusive"                   -- include last char in selection
vim.opt.mouse = "a"                               -- enable mouse support
vim.opt.clipboard:append("unnamedplus")           -- use system clipboard
vim.opt.modifiable = true                         -- allow buffer modifications

-- ============================================================================
-- KEYMAPS
-- ============================================================================
vim.g.mapleader = " "      -- space for leader
vim.g.maplocalleader = " " -- space for localleader

local map = vim.keymap.set
-- leader keymaps
map('n', '<leader>so', ':update<CR> :source<CR> :lua print("Config reloaded!")<CR>')
map('n', '<leader>e', ':lua MiniFiles.open()<CR>')
map('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- other
map('i', 'jj', '<Esc>')
map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- move code around
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- multiple lines
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<A-h>", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", "<A-l>", ">gv", { desc = "Indent right and reselect" })

-- QOL
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "<S-h>", ":bprevious<cr>")
vim.keymap.set("n", "<S-l>", ":bnext<cr>")
vim.keymap.set("n", "gl", "$")
vim.keymap.set("n", "gh", "^")
vim.keymap.set("n", "Y", "y$")

-- buffers
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true })
-- delete current
vim.api.nvim_set_keymap("n", "<leader>bd", ":confirm bd<CR>", { noremap = true, silent = true })

-- windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Split window horizontally
vim.api.nvim_set_keymap("n", "<leader>sh", ":split<CR>", { noremap = true, silent = true })
-- Split window vertically
vim.api.nvim_set_keymap("n", "<leader>sv", ":vsplit<CR>", { noremap = true, silent = true })
-- Close current window
vim.api.nvim_set_keymap("n", "<leader>cw", ":close<CR>", { noremap = true, silent = true })

-- ============================================================================
-- PLUGIN
-- ============================================================================
-- plugins
vim.pack.add({
  -- colorscheme
  { src = "https://github.com/vague2k/vague.nvim" },
  -- lsp
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  -- completion
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/Saghen/blink.cmp" },
  -- mini
  { src = "https://github.com/nvim-mini/mini.nvim" },
  -- git
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})
-- colorscheme
vim.cmd("colorscheme vague")

-- file explorer
require("mini.files").setup({
  windows = {
    preview = true,
    max_number = 3,
    width_no_focus = 10,
    width_preview = 50
  }
})
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.ai").setup()
require("mini.surround").setup()
require("mini.sessions").setup()
require("mini.cursorword").setup()
require("mini.indentscope").setup()
require("mini.notify").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()
local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE', PERF
    fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack      = { pattern = '%f[%w]()PERF()%f[%W]', group = 'MiniHipatternsHack' },
    todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },

})

-- lsp
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "rust_analyzer", "vtsls", "gopls", "pyright" },
}
-- rm global warnings
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      }
    }
  }
})


-- completion
require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
  signature = { enabled = true },
  keymap = {
    preset = 'default',
    ["<CR>"] = { "accept", "fallback" },
  },
  completion = {
    ghost_text = {
      enabled = true
    },
    list = {
      selection = {
        preselect = true
      }
    },
    documentation = {
      auto_show = true,
      auto_show_dealy = 300
    },
    menu = {
      auto_show = true,
    }
  },
  fuzzy = { implementation = "prefer_rust_with_warning" }
})

-- git
require('gitsigns').setup({
  current_line_blame = true
})
-- ============================================================================
-- AUTOMODS
-- ============================================================================
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.hl.on_yank()
  end,
})
