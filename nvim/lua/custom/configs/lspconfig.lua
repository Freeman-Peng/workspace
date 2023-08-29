local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

capabilities.textDocument.completion.completionItem.preselectSupport = false
local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "tsserver", "volar", "pylsp", "cmake", "gopls", "clangd", "jdtls" }

for _, lsp in ipairs(servers) do
  local config = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.server_capabilities.documentFormattingProvider = lspconfig[lsp].documentFormattingProvider
      client.server_capabilities.documentRangeFormattingProvider = lspconfig[lsp].documentRangeFormattingProvider
      if lsp == "clangd" then
        vim.api.nvim_buf_set_keymap(
          bufnr,
          "n",
          "<leader>w",
          "<cmd>ClangdSwitchSourceHeader<cr>",
          { noremap = true, silent = true }
        )
      elseif lsp == "gopls" then
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.go",
          callback = function()
            vim.lsp.buf.code_action { context = { only = { "source.organizeImports" } }, apply = true }
            vim.lsp.buf.format { async = false }
          end,
        })
      end
    end,
    capabilities = capabilities,
  }

  if lsp == "gopls" then
    config.settings = { gopls = { semanticTokens = true } }
  end

  lspconfig[lsp].setup(config)
end
