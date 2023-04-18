local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "tsserver", "volar", "pylsp", "cmake" }
local function autofmt(bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format { async = true }
    end,
  })
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.server_capabilities.documentFormattingProvider = lspconfig[lsp].documentFormattingProvider
      client.server_capabilities.documentRangeFormattingProvider = lspconfig[lsp].documentRangeFormattingProvider
      autofmt(bufnr)
    end,
    capabilities = capabilities,
  }
end

lspconfig["gopls"].setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = lspconfig["gopls"].documentFormattingProvider
    client.server_capabilities.documentRangeFormattingProvider = lspconfig["gopls"].documentRangeFormattingProvider

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.code_action { context = { only = { "source.organizeImports" } }, apply = true }
        vim.lsp.buf.format { async = false }
      end,
    })
  end,
  capabilities = capabilities,
}

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
    client.server_capabilities.documentformattingprovider = true
    client.server_capabilities.documentrangeformattingprovider = true

    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "<leader>w",
      "<cmd>clangdswitchsourceheader<cr>",
      { noremap = true, silent = true }
    )
    autofmt()
  end,
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
}
