return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { { "prettierd", "prettier" } },
        go = { "goimports", "gofmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
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
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "markdown" },
        callback = function(ev)
          vim.api.nvim_buf_set_keymap(0, "n", "<F12>", "<cmd>MarkdownPreview<CR>", { nowait = true })
        end,
      })
    end,
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "b0o/schemastore.nvim",
    ft = { "json" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "Marskey/telescope-sg" },
      { "debugloop/telescope-undo.nvim" },
    },
    keys = {
      { "<leader>u", "<cmd>Telescope undo<CR>", desc = "open telescope undo extensions" },
    },
    opts = require "configs.telescope",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require "configs.ibl"
    end,
  },
  {
    "phaazon/hop.nvim",
    keys = {
      { "gl", "<cmd>HopLine<cr>", desc = "easy move", mode = { "n", "v", "x" } },
      { "\\", "<cmd>HopChar1<cr>", desc = "global j", mode = { "n", "v", "x" } },
    },
    config = function()
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(opts)
      return require "configs.cmp"
    end,
  },
  {
    "mfussenegger/nvim-dap",
    ft = function()
      return require("configs.dapconfig").filetypes()
    end,
    config = function()
      require("configs.dapconfig").setup()
    end,
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("configs.dapuiconfig").setup()
        end,
      },
      "nvim-neotest/nvim-nio",
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require("nvim-dap-virtual-text").setup()
        end,
      },
    },
  },
}
