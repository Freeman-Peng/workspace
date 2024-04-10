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

      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ih", "", {
        nowait = true,
        desc = "toggle inlay hints",
        callback = function()
          vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
        end,
      })
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

      vim.api.nvim_set_keymap("n", "<leader>ih", "", {
        nowait = true,
        desc = "toggle inlay hints",
        callback = function()
          vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
        end,
        { buffer = true },
      })
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

if not vim.o.diff then
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
end
