local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

capabilities.textDocument.completion.completionItem.preselectSupport = false
local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "tsserver", "volar", "pylsp", "cmake", "gopls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.server_capabilities.documentFormattingProvider = lspconfig[lsp].documentFormattingProvider
      client.server_capabilities.documentRangeFormattingProvider = lspconfig[lsp].documentRangeFormattingProvider
    end,
    capabilities = capabilities,
  }
end

lspconfig["clangd"].setup {
  -- cmd = {
  -- 	"clangd",
  -- 	"--clang-tidy",
  -- 	"--completion-style=bundled",
  -- 	"--header-insertion=iwyu",
  -- 	"--all-scopes-completion",
  -- 	"--suggest-missing-includes",
  -- 	"--cross-file-rename",
  -- 	"--fallback-style=google",
  -- },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "<leader>w",
      "<cmd>ClangdSwitchSourceHeader<cr>",
      { noremap = true, silent = true }
    )
  end,
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
}
