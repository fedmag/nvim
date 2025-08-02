-- this contains the collection of general keymaps,
-- all the keymaps specific to a given plugin are stored
-- in that specific plugin file
local opts = { noremap = true, silent = true }

vim.keymap.set("v", "p", '"_dP', opts)
vim.keymap.set("n", "U", "<C-r>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<cr>", opts)
vim.keymap.set("n", "<S-l>", ":bnext<cr>", opts)
vim.keymap.set("n", "gl", "$", opts)
vim.keymap.set("n", "gh", "^", opts)
vim.keymap.set("n", "Y", "y$", opts)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- BUFFERS
-- Map Ctrl+s to save the current buffer
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true })
-- delete current
vim.api.nvim_set_keymap("n", "<leader>bd", ":confirm bd<CR>", { noremap = true, silent = true })
-- delete all others
vim.api.nvim_set_keymap("n", "<leader>bo", ":%bd|e#<CR>", { noremap = true, silent = true })

-- WINDOWS
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Split window horizontally
vim.api.nvim_set_keymap("n", "<leader>sh", ":split<CR>", opts)
-- Split window vertically
vim.api.nvim_set_keymap("n", "<leader>sv", ":vsplit<CR>", opts)
-- Close current window
vim.api.nvim_set_keymap("n", "<leader>cw", ":close<CR>", opts)

-- TERMINAL
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- vim.keymap.set({ "i", "n", "t" }, "<C-/>", ":ToggleTerm dir=%:p:h<CR>") -- open terminal in the directory of the file
vim.api.nvim_create_user_command('TermRoot', function()
  vim.cmd('ToggleTerm dir=' .. vim.fn.getcwd())
end, {})
vim.keymap.set({ "i", "n", "t" }, "<C-/>", ":TermRoot <CR>")
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })
