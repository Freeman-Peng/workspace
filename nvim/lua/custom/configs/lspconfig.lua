local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

capabilities.textDocument.completion.completionItem.preselectSupport = false
local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "tsserver", "volar", "pylsp", "cmake", "gopls", "clangd", "jdtls" }

local config = {
  clangd = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.server_capabilities.documentFormattingProvider = lspconfig["clangd"].documentFormattingProvider
      client.server_capabilities.documentRangeFormattingProvider = lspconfig["clangd"].documentRangeFormattingProvider
      vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>w",
        "<cmd>ClangdSwitchSourceHeader<cr>",
        { noremap = true, silent = true }
      )
    end,
    capabilities = capabilities,
  },

  gopls = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = lspconfig["gopls"].documentFormattingProvider
      client.server_capabilities.documentRangeFormattingProvider = lspconfig["gopls"].documentRangeFormattingProvider
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          vim.lsp.buf.code_action { context = { only = { "source.organizeImports" } }, apply = true }
          vim.lsp.buf.format { async = false }
        end,
      })
    end,
    capabilities = capabilities,
  },
}

for _, lsp in ipairs(servers) do
  if config[lsp] ~= nil then
    lspconfig[lsp].setup(config[lsp])
  else
    lspconfig[lsp].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end
end
