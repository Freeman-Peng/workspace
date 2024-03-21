local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

capabilities.general.positionEncodings = { "utf-8" }

local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "tsserver", "volar", "pylsp", "cmake", "gopls", "clangd", "jdtls" }

local config = {
  clangd = {
    cmd = { "clangd", "--completion-style=detailed", "--function-arg-placeholders" },
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>w",
        "<cmd>ClangdSwitchSourceHeader<cr>",
        { noremap = true, silent = true }
      )
      vim.lsp.inlay_hint.enable(bufnr, true)
    end,
    capabilities = capabilities,
  },

  gopls = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          vim.lsp.buf.code_action { context = { only = { "source.organizeImports" } }, apply = true }
          vim.lsp.buf.format { async = false }
        end,
      })
      vim.lsp.inlay_hint.enable(bufnr, true)
    end,
    capabilities = capabilities,
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  tsserver = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
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
