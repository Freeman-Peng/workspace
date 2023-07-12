local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

capabilities.textDocument.completion.completionItem.preselectSupport = false
local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "tsserver", "volar", "pylsp", "cmake", "gopls", "clangd" }

for _, lsp in ipairs(servers) do
  local settings = {}
  if lsp == "gopls" then
    local append = { gopls = { semanticTokens = true } }
    settings = vim.tbl_deep_extend("force", settings, append)
  end
  lspconfig[lsp].setup {
    settings = settings,
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
        if not client.server_capabilities.semanticTokensProvider then
          local semantic = client.config.capabilities.textDocument.semanticTokens
          client.server_capabilities.semanticTokensProvider = {
            full = true,
            legend = {
              tokenTypes = semantic.tokenTypes,
              tokenModifiers = semantic.tokenModifiers,
            },
            range = true,
          }
        end
      end
    end,
    capabilities = capabilities,
  }
end
