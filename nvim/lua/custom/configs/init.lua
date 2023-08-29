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
        "jdtls",
      },
    },
  },
  -- Override plugin definition options
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require "plugins.configs.lspconfig"
  --     require "custom.plugins.lspconfig"
  --   end,
  -- },

  -- null-ls
  --   {
  --     "jose-elias-alvarez/null-ls.nvim",
  --     after = "nvim-lspconfig",
  --     config = function()
  --       require "custom.plugins.null-ls"
  --     end,
  --   },
  --
  --   -- surround
  --   {"kylechui/nvim-surround",
  --     tag = "*",
  --     config = function()
  --       require("nvim-surround").setup {}
  --     end,
  --   },
  --
  --   {"liuchengxu/vista.vim",
  --     config = function()
  --       vim.g.vista_default_executive = "nvim_lsp"
  --       vim.g.vista_close_on_jump = 1
  --     end,
  --   },
  --
  --   {"hrsh7th/nvim-cmp",
  --     override_options = function()
  --       return {
  --         mapping = {
  --           ["<C-x><C-o>"] = require("cmp").mapping.complete(),
  --         },
  --       }
  --     end,
  --   },
  --
  --   {"kyazdani42/nvim-tree.lua",
  --     override_options = function()
  --       return {
  --         filters = {
  --           dotfiles = true,
  --           git_clean = true,
  --         },
  --         git = {
  --           ignore = true,
  --         },
  --       }
  --     end,
  --   },
}
