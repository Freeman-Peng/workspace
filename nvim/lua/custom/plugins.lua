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
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    opts = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  -- null-ls
  -- surround
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "liuchengxu/vista.vim",
    config = function()
      vim.g.vista_default_executive = "nvim_lsp"
      vim.g.vista_close_on_jump = 1
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        ["<C-x><C-o>"] = require("cmp").mapping.complete(),
        ["<C-Space>"] = nil,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",

        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        -- "vue", "svelte",
        "vue",

        -- low level
        "c",
        "cpp",
      },
    },
  },
}
