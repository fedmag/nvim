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
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true })
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
require("fzf-lua").setup({})

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

