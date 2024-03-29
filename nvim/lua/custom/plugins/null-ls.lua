local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local b = null_ls.builtins

local sources = {

	-- webdev stuff
	b.formatting.prettier.with({
		filetypes = {
			"html",
			"markdown",
			"css",
			"scss",
			"json",
			"yaml",
			"typescriptreact",
			"typescript",
			"javascriptreact",
			"javascript",
			"less",
			"vue",
		},
	}),

	-- Lua
	b.formatting.stylua,

	-- Shell
	b.formatting.shfmt,
	b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

	-- rust
	b.formatting.rustfmt,

	-- go
	b.formatting.gofmt,

	-- python
	b.formatting.yapf,

	-- protobuf
	b.diagnostics.protolint,
	b.formatting.protolint,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = true,
	sources = sources,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,
})
