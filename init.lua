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
vim.opt.colorcolumn = ""                          -- do not show a column at 100 position chars
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


----
---
---
---
---
---

map("n", "<leader><space>", function() require('snacks').picker.smart() end, { desc = "Smart Find Files" })
map("n", "<leader>,",       function() require('snacks').picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>/",       function() require('snacks').picker.grep() end, { desc = "Grep" })
map("n", "<leader>:",       function() require('snacks').picker.command_history() end, { desc = "Command History" })
map("n", "<leader>n",       function() require('snacks').picker.notifications() end, { desc = "Notification History" })
map("n", "<leader>e",       function() require('snacks').explorer() end, { desc = "File Explorer" })
-- find
map("n", "<leader>fb",      function() require('snacks').picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>fc",      function() require('snacks').picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })
map("n", "<leader>ff",      function() require('snacks').picker.files() end, { desc = "Find Files" })
map("n", "<leader>fg",      function() require('snacks').picker.git_files() end, { desc = "Find Git Files" })
map("n", "<leader>fp",      function() require('snacks').picker.projects() end, { desc = "Projects" })
map("n", "<leader>fr",      function() require('snacks').picker.recent() end, { desc = "Recent" })
-- git
map("n", "<leader>gb",      function() require('snacks').picker.git_branches() end, { desc = "Git Branches" })
map("n", "<leader>gl",      function() require('snacks').picker.git_log() end, { desc = "Git Log" })
map("n", "<leader>gL",      function() require('snacks').picker.git_log_line() end, { desc = "Git Log Line" })
map("n", "<leader>gs",      function() require('snacks').picker.git_status() end, { desc = "Git Status" })
map("n", "<leader>gS",      function() require('snacks').picker.git_stash() end, { desc = "Git Stash" })
map("n", "<leader>gd",      function() require('snacks').picker.git_diff() end, { desc = "Git Diff (Hunks)" })
map("n", "<leader>gf",      function() require('snacks').picker.git_log_file() end, { desc = "Git Log File" })
-- gh
map("n", "<leader>gi",      function() require('snacks').picker.gh_issue() end, { desc = "GitHub Issues (open)" })
map("n", "<leader>gI",      function() require('snacks').picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)" })
map("n", "<leader>gp",      function() require('snacks').picker.gh_pr() end, { desc = "GitHub Pull Requests (open)" })
map("n", "<leader>gP",      function() require('snacks').picker.gh_pr({ state = "all" }) end, { desc = "GitHub Pull Requests (all)" })
-- Grep
map("n", "<leader>sb",      function() require('snacks').picker.lines() end, { desc = "Buffer Lines" })
map("n", "<leader>sB",      function() require('snacks').picker.grep_buffers() end, { desc = "Grep Open Buffers" })
map("n", "<leader>sg",      function() require('snacks').picker.grep() end, { desc = "Grep" })
map({ "n", "x" }, "<leader>sw", function() require('snacks').picker.grep_word() end, { desc = "Visual selection or word" })
-- search
map("n", '<leader>s"',      function() require('snacks').picker.registers() end, { desc = "Registers" })
map("n", '<leader>s/',      function() require('snacks').picker.search_history() end, { desc = "Search History" })
map("n", "<leader>sa",      function() require('snacks').picker.autocmds() end, { desc = "Autocmds" })
map("n", "<leader>sb",      function() require('snacks').picker.lines() end, { desc = "Buffer Lines" })
map("n", "<leader>sc",      function() require('snacks').picker.command_history() end, { desc = "Command History" })
map("n", "<leader>sC",      function() require('snacks').picker.commands() end, { desc = "Commands" })
map("n", "<leader>sd",      function() require('snacks').picker.diagnostics() end, { desc = "Diagnostics" })
map("n", "<leader>sD",      function() require('snacks').picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
map("n", "<leader>sh",      function() require('snacks').picker.help() end, { desc = "Help Pages" })
map("n", "<leader>sH",      function() require('snacks').picker.highlights() end, { desc = "Highlights" })
map("n", "<leader>si",      function() require('snacks').picker.icons() end, { desc = "Icons" })
map("n", "<leader>sj",      function() require('snacks').picker.jumps() end, { desc = "Jumps" })
map("n", "<leader>sk",      function() require('snacks').picker.keymaps() end, { desc = "Keymaps" })
map("n", "<leader>sl",      function() require('snacks').picker.loclist() end, { desc = "Location List" })
map("n", "<leader>sm",      function() require('snacks').picker.marks() end, { desc = "Marks" })
map("n", "<leader>sM",      function() require('snacks').picker.man() end, { desc = "Man Pages" })
map("n", "<leader>sp",      function() require('snacks').picker.lazy() end, { desc = "Search for Plugin Spec" })
map("n", "<leader>sq",      function() require('snacks').picker.qflist() end, { desc = "Quickfix List" })
map("n", "<leader>sR",      function() require('snacks').picker.resume() end, { desc = "Resume" })
map("n", "<leader>su",      function() require('snacks').picker.undo() end, { desc = "Undo History" })
map("n", "<leader>uC",      function() require('snacks').picker.colorschemes() end, { desc = "Colorschemes" })
-- LSP
map("n", "gd",              function() require('snacks').picker.lsp_definitions() end, { desc = "Goto Definition" })
map("n", "gD",              function() require('snacks').picker.lsp_declarations() end, { desc = "Goto Declaration" })
map("n", "gr",              function() require('snacks').picker.lsp_references() end, { nowait = true, desc = "References" })
map("n", "gI",              function() require('snacks').picker.lsp_implementations() end, { desc = "Goto Implementation" })
map("n", "gy",              function() require('snacks').picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
map("n", "gai",             function() require('snacks').picker.lsp_incoming_calls() end, { desc = "C[a]lls Incoming" })
map("n", "gao",             function() require('snacks').picker.lsp_outgoing_calls() end, { desc = "C[a]lls Outgoing" })
map("n", "<leader>ss",      function() require('snacks').picker.lsp_symbols() end, { desc = "LSP Symbols" })
map("n", "<leader>sS",      function() require('snacks').picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })
-- Other
map("n", "<leader>z",       function() require('snacks').zen() end, { desc = "Toggle Zen Mode" })
map("n", "<leader>Z",       function() require('snacks').zen.zoom() end, { desc = "Toggle Zoom" })
map("n", "<leader>.",       function() require('snacks').scratch() end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S",       function() require('snacks').scratch.select() end, { desc = "Select Scratch Buffer" })
map("n", "<leader>n",       function() require('snacks').notifier.show_history() end, { desc = "Notification History" })
map("n", "<leader>bd",      function() require('snacks').bufdelete() end, { desc = "Delete Buffer" })
map("n", "<leader>cR",      function() require('snacks').rename.rename_file() end, { desc = "Rename File" })
map({ "n", "v" }, "<leader>gB", function() require('snacks').gitbrowse() end, { desc = "Git Browse" })
map("n", "<leader>gg",      function() require('snacks').lazygit() end, { desc = "Lazygit" })
map("n", "<leader>un",      function() require('snacks').notifier.hide() end, { desc = "Dismiss All Notifications" })
map("n", "<c-/>",           function() require('snacks').terminal() end, { desc = "Toggle Terminal" })
map("n", "<c-_>",           function() require('snacks').terminal() end, { desc = "which_key_ignore" })
map({ "n", "t" }, "]]",     function() require('snacks').words.jump(vim.v.count1) end, { desc = "Next Reference" })
map({ "n", "t" }, "[[",     function() require('snacks').words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
map("n", "<leader>N", function()
  require('snacks').win({
    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
    width = 0.6,
    height = 0.6,
    wo = {
      spell = false,
      wrap = false,
      signcolumn = "yes",
      statuscolumn = " ",
      conceallevel = 3,
    },
  })
end, { desc = "Neovim News" })

-- ============================================================================
-- PLUGIN
-- ============================================================================

-- ===== INTSTALL =====
vim.pack.add({
  -- colorscheme
  { src = "https://github.com/vague2k/vague.nvim" },
  -- lsp
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/folke/snacks.nvim" },

  -- completion
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/Saghen/blink.cmp" },
  -- mini
  { src = "https://github.com/nvim-mini/mini.nvim" },
  -- git
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  -- treesitter
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate'
  }
})

-- ===== COLORSCHEME =====
vim.cmd("colorscheme vague")

-- ===== MINI =====
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
require("mini.pick").setup()
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

-- ===== LSP =====
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "vtsls", "gopls", "pyright" },
}

require("snacks").setup({
  -- local Snacks = require("snacks")
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = {
    -- Top Pickers & Explorer
  },
})

require("fzf-lua").setup({})
vim.lsp.config('*', {
  { "gd", vim.lsp.buf.definition,                             desc = "Goto Definition",       has = "definition" },
  { "gr", vim.lsp.buf.references,                             desc = "References",            nowait = true },
  { "gI", vim.lsp.buf.implementation,                         desc = "Goto Implementation" },
  { "gy", vim.lsp.buf.type_definition,                        desc = "Goto T[y]pe Definition" },
  { "gD", vim.lsp.buf.declaration,                            desc = "Goto Declaration" },
  { "K",  function() return vim.lsp.buf.hover() end,          desc = "Hover" },
  { "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help",        has = "signatureHelp" },
})


local function lsp_on_attach(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if not client then
    return
  end

  local bufnr = ev.buf
  local opts = { noremap = true, silent = true, buffer = bufnr }


  vim.keymap.set("n", "<leader>gd", function()
    require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
  end, opts)

  vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)

  vim.keymap.set("n", "<leader>gS", function()
    vim.cmd("vsplit")
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

  vim.keymap.set("n", "<leader>D", function()
    vim.diagnostic.open_float({ scope = "line" })
  end, opts)
  vim.keymap.set("n", "<leader>d", function()
    vim.diagnostic.open_float({ scope = "cursor" })
  end, opts)
  vim.keymap.set("n", "<leader>nd", function()
    vim.diagnostic.jump({ count = 1 })
  end, opts)

  vim.keymap.set("n", "<leader>pd", function()
    vim.diagnostic.jump({ count = -1 })
  end, opts)

  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

  vim.keymap.set("n", "<leader>fd", function()
    require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
  end, opts)
  vim.keymap.set("n", "<leader>fr", function()
    require("fzf-lua").lsp_references()
  end, opts)
  vim.keymap.set("n", "<leader>ft", function()
    require("fzf-lua").lsp_typedefs()
  end, opts)
  vim.keymap.set("n", "<leader>fs", function()
    require("fzf-lua").lsp_document_symbols()
  end, opts)
  vim.keymap.set("n", "<leader>fw", function()
    require("fzf-lua").lsp_workspace_symbols()
  end, opts)
  vim.keymap.set("n", "<leader>fi", function()
    require("fzf-lua").lsp_implementations()
  end, opts)

  if client:supports_method("textDocument/codeAction", bufnr) then
    vim.keymap.set("n", "<leader>oi", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        apply = true,
        bufnr = bufnr,
      })
      vim.defer_fn(function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end, 50)
    end, opts)
  end
end


vim.keymap.set("n", "<leader>q", function()
  vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })






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

-- ===== COMPLETION =====
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
  appearance = { nerd_font_variant = "mono" },
  sources = { default = { "lsp", "path", "buffer", "snippets" } },
  snippets = {
    expand = function(snippet)
      require("luasnip").lsp_expand(snippet)
    end,
  },
  fuzzy = {
    implementation = "prefer_rust",
    prebuilt_binaries = { download = true },
  },
})

-- ===== GIT =====
require('gitsigns').setup({
  current_line_blame = true
})

-- ===== TREESITTER =====
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

-- ===== DIAGNOSTIC =====
local diagnostic_signs = {
  Error = " ",
  Warn = " ",
  Hint = "",
  Info = "",
}

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
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
    focusable = false,
    style = "minimal",
  },
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
vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

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
