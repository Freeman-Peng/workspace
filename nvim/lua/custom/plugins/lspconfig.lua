local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = { "gopls", "html", "cssls", "tsserver", "volar", "pylsp", "cmake" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig["clangd"].setup({
	cmd = {
		"clangd",
		"--clang-tidy",
		"--completion-style=bundled",
		"--header-insertion=iwyu",
	},
	on_attach = on_attach,
	capabilities = capabilities,
})
