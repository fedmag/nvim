return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	enabled = not vim.g.vscode,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		triggers = {
			{ "<leader>", mode = { "n", "v" } },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
