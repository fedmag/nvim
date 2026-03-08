-- config built for nvim v0.12
-- updated on: 2026-03-06
--
-- there are 4 sections:
-- OPTIONS: general built-in options
-- KEYMAPS: movements, navigation and file explorer
-- PLUGINS: divided into macrocategories, each containing multiple plugins. Ex:
--        - COLORSCHEME: all colorschemes
--        - MINI: everything related to mini.nvim
--        - LSP and COMPLETION: mason, mason-lspconfig, nvim-lspconfig, blink, fzf-lua
--        - TREESITTER: all related to treesitter
--        ...
--        ...
-- AUTOCMDS: all autocmds
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
vim.opt.colorcolumn = ""                          -- do not show a column at 100 position chars
vim.opt.showmatch = true                          -- highlights matching brackets
vim.opt.cmdheight = 1                             -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.iskeyword:append("-")                     -- include - in words
vim.opt.path:append("**")                         -- include subdirs in search
vim.opt.selection = "inclusive"                   -- include last char in selection
vim.opt.mouse = "a"                               -- enable mouse support
vim.opt.clipboard = "unnamedplus"                 -- use system clipboard
vim.opt.modifiable = true                         -- allow buffer modifications

vim.opt.splitbelow = true                         -- horizontal splits go below
vim.opt.splitright = true                         -- vertical splits go right


-- ===== DIAGNOSTIC =====
local diagnostic_signs = {
  Error = " ",
  Warn = " ",
  Hint = "",
  Info = "",
}
--
vim.diagnostic.config({
  -- virtual_text = { prefix = "●", spacing = 4 },
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
      [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
      [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
      [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    focusable = true,
    style = "minimal",
  },
})

-- ============================================================================
-- KEYMAPS
-- ============================================================================
vim.g.mapleader = " "      -- space for leader
vim.g.maplocalleader = " " -- space for localleader

local map = vim.keymap.set
-- leader keymaps
map('n', '<leader>so', ':update<CR> :source<CR> :lua print("Config reloaded!")<CR>')
map('n', '<leader>e', ':lua MiniFiles.open()<CR>')
map('n', '<leader>ef', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>')
map('n', '<leader>ed', '<Cmd>lua MiniFiles.open()<CR>')

map('n', '<leader>lf', vim.lsp.buf.format)
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- other
map('i', 'jj', '<Esc>')
map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- move code around
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- multiple lines
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<A-h>", "<gv", { desc = "Indent left and reselect" })
map("v", "<A-l>", ">gv", { desc = "Indent right and reselect" })

-- QOL
map("v", "p", '"_dP')
map("n", "U", "<C-r>")
map("n", "<S-h>", ":bprevious<cr>")
map("n", "<S-l>", ":bnext<cr>")
map("n", "gl", "$")
map("n", "gh", "^")
map("n", "Y", "y$")

-- buffers
-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
-- delete current
vim.api.nvim_set_keymap("n", "<leader>bd", ":confirm bd<CR>", { noremap = true, silent = true })

-- windows
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Split window horizontally
vim.api.nvim_set_keymap("n", "<leader>sh", ":split<CR>", { noremap = true, silent = true })
-- Split window vertically
vim.api.nvim_set_keymap("n", "<leader>sv", ":vsplit<CR>", { noremap = true, silent = true })
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
-- Close current window
vim.api.nvim_set_keymap("n", "<leader>cw", ":close<CR>", { noremap = true, silent = true })

-- ============================================================================
-- PLUGINS
-- ============================================================================

-- ===== COLORSCHEME =====
vim.pack.add({
  -- colorscheme
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/theisimonho/kanagawa-paper.nvim" },
})
require("kanagawa-paper").setup({
  styles = {
    comment = {
      italic = true
    }
  }
})
vim.cmd("colorscheme kanagawa-paper-ink")

-- ===== MINI =====
local tst = {
  test = true
}
local tst = {
  test = false
}
vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.nvim" },
})
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
require("mini.cursorword").setup()
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

-- ===== LSP and COMPLETION =====
vim.pack.add({
  -- lsp
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  -- completion
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/Saghen/blink.cmp" },
})
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "vtsls", "gopls", "pyright" },
}

-- rm global warnings
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
    },
  },
})
vim.lsp.config("pyright", {})
vim.lsp.config("vtsls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})

vim.lsp.config["*"] = {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
}

vim.lsp.enable({
  "lua_ls",
  "pyright",
  "vtsls",
  "gopls",
})

require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
  signature = { enabled = true },
  keymap = {
    preset = 'default',
    ["<TAB>"] = { "accept", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
  },
  completion = {
    ghost_text = {
      enabled = true,
    },
    list = {
      selection = {
        preselect = true
      }
    },
    documentation = {
      auto_show = true,
    },
    menu = {
      auto_show = true,
    }
  },
  appearance = { nerd_font_variant = "mono" },
  sources = { default = { "lsp", "path", "buffer", "snippets" } },
  snippets = {
    expand = function(snippet)
      require("luasnip").lsp_expand(snippet)
    end,
  },
  fuzzy = {
    implementation = "lua",
    prebuilt_binaries = { download = true, force_version = "v0.8.2" },
  },
})

-- ===== SNACKS =====
vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
})

require("snacks").setup({
  bigfile = { enabled = true },
  indent = {
    enabled = true,
    indent = {
      hl = {
        "SnacksIndent1",
        "SnacksIndent2",
        "SnacksIndent3",
        "SnacksIndent4",
        "SnacksIndent5",
        "SnacksIndent6",
        "SnacksIndent7",
        "SnacksIndent8",
      },
      -- char = "|"
    },
    scope = {
      hl = {
        "SnacksIndent1",
        "SnacksIndent2",
        "SnacksIndent3",
        "SnacksIndent4",
        "SnacksIndent5",
        "SnacksIndent6",
        "SnacksIndent7",
        "SnacksIndent8",
      },
      -- char = "╎",
      char = "|"
    },
  },
  scope = {
    enabled = true,
    scope = {}
  },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  picker = {
    enabled = true,
    layouts = {
      horizontalMax = {
        layout = {
          box = "horizontal",
          width = 0.95,
          min_width = 120,
          height = 0.95,
          {
            box = "vertical",
            border = true,
            title = "{title} {live} {flags}",
            { win = "input", height = 1,     border = "bottom" },
            { win = "list",  border = "none" },
          },
          { win = "preview", title = "{preview}", border = true, width = 0.5 },
        }
      },
      verticalMax = {
        layout = {
          backdrop = false,
          width = 0.95,
          min_width = 80,
          height = 0.95,
          min_height = 30,
          box = "vertical",
          border = true,
          title = "{title} {live} {flags}",
          title_pos = "center",
          { win = "input",   height = 1,          border = "bottom" },
          { win = "list",    border = "top" },
          { win = "preview", title = "{preview}", height = 0.5,     border = "top" },
        },
      }
    },
    layout = {
      preset = function()
        return vim.o.columns >= 120 and "horizontalMax" or "verticalMax"
      end,
    }
  },
})

require("fzf-lua").setup({})

-- Taken from snacks.picker GH
map("n", "<leader><space>", function() require('snacks').picker.smart() end, { desc = "Smart Find Files" })
map("n", "<leader>,", function() require('snacks').picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>/", function() require('snacks').picker.grep() end, { desc = "Grep" })
map("n", "<leader>:", function() require('snacks').picker.command_history() end, { desc = "Command History" })
map("n", "<leader>n", function() require('snacks').picker.notifications() end, { desc = "Notification History" })
--
-- [F]ind
map("n", "<leader>fb", function() require('snacks').picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>fc", function() require('snacks').picker.files({ cwd = vim.fn.stdpath("config") }) end,
  { desc = "Find Config File" })
map("n", "<leader>ff", function() require('snacks').picker.files() end, { desc = "Find Files" })
map("n", "<leader>fgf", function() require('snacks').picker.git_files() end, { desc = "Find Git Files" })
map("n", "<leader>fp", function() require('snacks').picker.projects() end, { desc = "Projects" })
map("n", "<leader>fr", function() require('snacks').picker.recent() end, { desc = "Recent" })
--
-- [GI]t
map("n", "<leader>gib", function() require('snacks').picker.git_branches() end, { desc = "Git Branches" })
map("n", "<leader>gil", function() require('snacks').picker.git_log() end, { desc = "Git Log" })
map("n", "<leader>giL", function() require('snacks').picker.git_log_line() end, { desc = "Git Log Line" })
map("n", "<leader>gis", function() require('snacks').picker.git_status() end, { desc = "Git Status" })
map("n", "<leader>giS", function() require('snacks').picker.git_stash() end, { desc = "Git Stash" })
map("n", "<leader>gid", function() require('snacks').picker.git_diff() end, { desc = "Git Diff (Hunks)" })
map("n", "<leader>gif", function() require('snacks').picker.git_log_file() end, { desc = "Git Log File" })
map("n", "<leader>gg", function() require('snacks').lazygit() end, { desc = "Lazygit" })
--
-- [G]rep
map("n", "<leader>gl", function() require('snacks').picker.lines() end, { desc = "Grep this buffer Lines" })
map("n", "<leader>gb", function() require('snacks').picker.grep_buffers() end, { desc = "Grep in Open Buffers" })
-- map("n", "<leader>gr", function() require('snacks').picker.grep() end, { desc = "Grep" })
map("n", "<leader>fg", function() require('snacks').picker.grep() end, { desc = "Grep" })
map({ "n", "x" }, "<leader>gw", function() require('snacks').picker.grep_word() end,
  { desc = "Visual selection or word" })
--
-- [S]earch
map("n", '<leader>s"', function() require('snacks').picker.registers() end, { desc = "Registers" })
map("n", '<leader>s/', function() require('snacks').picker.search_history() end, { desc = "Search History" })
map("n", "<leader>sa", function() require('snacks').picker.autocmds() end, { desc = "Autocmds" })
map("n", "<leader>sb", function() require('snacks').picker.lines() end, { desc = "Buffer Lines" })
map("n", "<leader>sc", function() require('snacks').picker.command_history() end, { desc = "Command History" })
map("n", "<leader>sC", function() require('snacks').picker.commands() end, { desc = "Commands" })
map("n", "<leader>sd", function() require('snacks').picker.diagnostics() end, { desc = "Diagnostics" })
map("n", "<leader>sD", function() require('snacks').picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
map("n", "<leader>sh", function() require('snacks').picker.help() end, { desc = "Help Pages" })
map("n", "<leader>sH", function() require('snacks').picker.highlights() end, { desc = "Highlights" })
map("n", "<leader>si", function() require('snacks').picker.icons() end, { desc = "Icons" })
map("n", "<leader>sj", function() require('snacks').picker.jumps() end, { desc = "Jumps" })
map("n", "<leader>sk", function() require('snacks').picker.keymaps() end, { desc = "Keymaps" })
map("n", "<leader>sl", function() require('snacks').picker.loclist() end, { desc = "Location List" })
map("n", "<leader>sm", function() require('snacks').picker.marks() end, { desc = "Marks" })
map("n", "<leader>sM", function() require('snacks').picker.man() end, { desc = "Man Pages" })
map("n", "<leader>sp", function() require('snacks').picker.lazy() end, { desc = "Search for Plugin Spec" })
map("n", "<leader>sq", function() require('snacks').picker.qflist() end, { desc = "Quickfix List" })
map("n", "<leader>sR", function() require('snacks').picker.resume() end, { desc = "Resume" })
map("n", "<leader>col", function() require('snacks').picker.colorschemes() end, { desc = "Colorschemes" })
--
-- LSP - [G]oto...
map("n", "gd", function() require('snacks').picker.lsp_definitions() end, { desc = "Goto Definition" })
map("n", "gD", function() require('snacks').picker.lsp_declarations() end, { desc = "Goto Declaration" })
map("n", "grr", function() require('snacks').picker.lsp_references() end, { nowait = true, desc = "References" })
map("n", "gI", function() require('snacks').picker.lsp_implementations() end, { desc = "Goto Implementation" })
map("n", "gy", function() require('snacks').picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
map("n", "gai", function() require('snacks').picker.lsp_incoming_calls() end, { desc = "C[a]lls Incoming" })
map("n", "gao", function() require('snacks').picker.lsp_outgoing_calls() end, { desc = "C[a]lls Outgoing" })
map("n", "<leader>ss", function() require('snacks').picker.lsp_symbols() end, { desc = "LSP Symbols" })
map("n", "<leader>sS", function() require('snacks').picker.lsp_workspace_symbols() end,
  { desc = "LSP Workspace Symbols" })

-- Other
map("n", "<leader>z", function() require('snacks').zen() end, { desc = "Toggle Zen Mode" })
map("n", "<leader>Z", function() require('snacks').zen.zoom() end, { desc = "Toggle Zoom" })
map("n", "<leader>.", function() require('snacks').scratch() end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", function() require('snacks').scratch.select() end, { desc = "Select Scratch Buffer" })
map("n", "<leader>n", function() require('snacks').notifier.show_history() end, { desc = "Notification History" })
map("n", "<leader>bd", function() require('snacks').bufdelete() end, { desc = "Delete Buffer" })
map("n", "<leader>cR", function() require('snacks').rename.rename_file() end, { desc = "Rename File" })
map({ "n", "v" }, "<leader>gB", function() require('snacks').gitbrowse() end, { desc = "Git Browse" })
map("n", "<leader>un", function() require('snacks').notifier.hide() end, { desc = "Dismiss All Notifications" })
map({ "n", "t" }, "]]", function() require('snacks').words.jump(vim.v.count1) end, { desc = "Next Reference" })
map({ "n", "t" }, "[[", function() require('snacks').words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

-- ===== GIT =====
vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require('gitsigns').setup({
  current_line_blame = true
})

-- ===== TREESITTER =====
vim.pack.add({
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate'
  },
})

require("nvim-treesitter").setup({
  highlight = {
    enable = true, -- Enable Tree-Sitter-based syntax highlighting
  },
  fold = {
    enable = true, -- Enable code folding
  }
})
-- Folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = "expr"                          -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99                               -- start with all folds open
vim.opt.foldenable = false

-- ===== SESSIONS =====
vim.pack.add({
  { src = "https://github.com/rmagatti/auto-session" },
})

require('auto-session').setup({})
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- ===== TMUX =====
vim.pack.add({
  { src = "https://github.com/alexghergh/nvim-tmux-navigation" },
})

local tmux = require('nvim-tmux-navigation')
tmux.setup({
  disabled_when_zoomed = true
})
map('n', "<C-h>", tmux.NvimTmuxNavigateLeft)
map('n', "<C-j>", tmux.NvimTmuxNavigateDown)
map('n', "<C-k>", tmux.NvimTmuxNavigateUp)
map('n', "<C-l>", tmux.NvimTmuxNavigateRight)
map('n', "<C-\\>", tmux.NvimTmuxNavigateLastActive)
map('n', "<C-Space>", tmux.NvimTmuxNavigateNext)


-- ===== DIAGNOSTIC =====
vim.pack.add({
  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
})
require("tiny-inline-diagnostic").setup({
  preset = "modern",
  options = {
    show_source = { enabled = true },
  },
  multilines = {
    enabled = true,           -- Enable support for multiline diagnostic messages
    always_show = false,      -- Always show messages on all lines of multiline diagnostics
    trim_whitespaces = false, -- Remove leading/trailing whitespace from each line
    tabstop = 4,              -- Number of spaces per tab when expanding tabs
    severity = nil,           -- Filter multiline diagnostics by severity (e.g., { vim.diagnostic.severity.ERROR })
  },
})

vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics

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
-----------------------

-- this is needed so that the diagnostic window shows up if we are on that specific line
local function au(typ, pattern, cmdOrFn)
  if type(cmdOrFn) == 'function' then
    vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = augroup })
  else
    vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = augroup })
  end
end

au({ 'CursorHold', 'InsertLeave' }, nil, function()
  local opts = {
    focusable = false,
    scope = 'cursor',
    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
  }
  vim.diagnostic.open_float(nil, opts)
end)

au('InsertEnter', nil, function()
  vim.diagnostic.enable(false)
end)

au('InsertLeave', nil, function()
  vim.diagnostic.enable(true)
end)
-----------------------

-- start treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})
-----------------------

-- format onsave
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  callback = function()
    local curr_buff_name = vim.api.nvim_buf_get_name(0)
    vim.notify(string.format("formatting %s", curr_buff_name))
    vim.lsp.buf.format({ async = false })
  end,
})
-----------------------
