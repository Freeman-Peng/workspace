local M = {
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			css = { "prettier" },
			html = { "prettierd" },
			vue = { "prettierd" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			pythnon = { "autopep8" },
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
	},
	ft = {},
}

for k, _ in pairs(M.opts.formatters_by_ft) do
	M.ft[#M.ft + 1] = k
end

return M
