local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = { "gopls", "html", "cssls", "tsserver", "volar", "pylsp", "cmake" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_list = on_list,
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
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true

    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "<leader>w",
      "<cmd>ClangdSwitchSourceHeader<cr>",
      { noremap = true, silent = true }
    )

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })
  end,
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
}
