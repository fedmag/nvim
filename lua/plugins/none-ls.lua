-- this is for linting and formatting
return {
	"nvimtools/none-ls.nvim",
	enabled = not vim.g.vscode,
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local nls = require("null-ls")
		nls.setup({
			sources = {
				nls.builtins.formatting.stylua,
				nls.builtins.formatting.prettier,
				-- go
				nls.builtins.code_actions.gomodifytags,
				nls.builtins.code_actions.impl,
				nls.builtins.formatting.goimports,
				nls.builtins.diagnostics.golangci_lint,
				-- other
				require("none-ls.diagnostics.eslint_d"),
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format()
						end,
					})
				end
			end,
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
