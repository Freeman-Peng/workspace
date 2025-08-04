local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettier" },
		html = { "prettier" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		go = { "goimports", "gofmt" },
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},

	format_after_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
	},
}

return options
