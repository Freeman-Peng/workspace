local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "lua_ls",
  "html",
  "cssls",
  "tsserver",
  "volar",
  "pylsp",
  "cmake",
  "gopls",
  "clangd",
  "jdtls",
  "emmet_ls",
  "jsonls",
}
local map = vim.keymap.set

local custom_map = function(bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end
  map("n", "<F1>", ":Telescope lsp_document_symbols<CR>", opts "show current symbols")
  map("n", "<leader>ds", ":Telescope lsp_document_symbols<CR>", opts "show current symbols")
  map("n", "<leader>q", ":Telescope diagnostics<CR>", opts "show diagnostics window")
  map("n", "]d", vim.diagnostic.goto_next, opts "goto prev dignositc")
  map("n", "[d", vim.diagnostic.goto_prev, opts "goto prev dignositc")
  map("n", "<leader>lf", vim.diagnostic.open_float, opts "show float diagnostic")
  map("n", "gr", ":Telescope lsp_references<CR>", opts "show reference")
  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", ":Telescope lsp_definitions<CR>", opts "Go to declaration")
end

local settings = {
  -- pylsp = {
  --   settings = {
  --     pylsp = {
  --       plugins = {
  --         pycodestyle = {
  --           ignore = { "E402" },
  --         },
  --       },
  --     },
  --   },
  -- },
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  local opts = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      custom_map(bufnr)
    end,
    capabilities = capabilities,
  }
  if settings[lsp] ~= nil then
    opts = vim.tbl_extend("keep", opts, settings[lsp])
  end

  lspconfig[lsp].setup(opts)
end
