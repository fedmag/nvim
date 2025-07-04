return {
	"vscode-neovim/vscode-multi-cursor.nvim",
	enabled = vim.g.vscode,
	event = "VeryLazy",
	cond = not not vim.g.vscode,
	opts = {},
}
