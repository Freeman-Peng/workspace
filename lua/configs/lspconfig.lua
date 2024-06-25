local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers =
  { "lua_ls", "html", "cssls", "tsserver", "volar", "pylsp", "cmake", "gopls", "clangd", "jdtls", "emmet_ls" }
local map = vim.keymap.set

local custom_map = function()
  map("n", "<F1>", ":Telescope lsp_document_symbols<CR>")
  map("n", "]d", vim.diagnostic.goto_next)
  map("n", "[d", vim.diagnostic.goto_prev)
  map("n", "<leader>lf", vim.diagnostic.open_float)
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = function(client, bufnr)
      custom_map()
      on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
  }
end

require("lspconfig").jsonls.setup {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
  on_attach = function(client, bufnr)
    custom_map()
    on_attach(client, bufnr)
  end,
  on_init = on_init,
  capabilities = capabilities,
}
