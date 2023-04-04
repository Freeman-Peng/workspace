return {
  {
   "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "cmake-language-server",
        "css-lsp",
        "gopls",
        "html-lsp",
        "lua-language-server",
        "prettier",
        "protolint",
        "python-lsp-server",
        "shfmt",
        "stylua",
        "typescript-language-server",
        "vue-language-server",
        "yapf",
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "custom.configs.null-ls"
    end,
  },
  -- surround
  {"kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {"liuchengxu/vista.vim",
    config = function()
      vim.g.vista_default_executive = "nvim_lsp"
      vim.g.vista_close_on_jump = 1
    end,
  },

  {"hrsh7th/nvim-cmp",
    keys = {
      {"<C-x><C-o>", require("cmp").mapping.complete(), mode="i","replace omni complete"},
    }
  },
}
