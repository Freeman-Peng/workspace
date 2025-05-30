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
				"emmet-ls",
				"tailwindcss-language-server",
			},
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
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
			require("configs.lspconfig")
		end,
	},
	{
		"b0o/schemastore.nvim",
		ft = { "json" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = require("configs.treesitter"),
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "Marskey/telescope-sg" },
			{ "debugloop/telescope-undo.nvim" },
		},
		keys = {
			{ "<leader>u", "<cmd>Telescope undo<CR>", desc = "open telescope undo extensions" },
		},
		opts = require("configs.telescope"),
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("configs.ibl")
		end,
	},
	{
		"phaazon/hop.nvim",
		keys = {
			{ "gl", "<cmd>HopLine<cr>", desc = "easy move", mode = { "n", "v", "x" } },
			{ "\\", "<cmd>HopChar1<cr>", desc = "global j", mode = { "n", "v", "x" } },
		},
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function(opts)
			return require("configs.cmp")
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
	{
		"sphamba/smear-cursor.nvim",
		event = "VeryLazy",
		opts = {
			-- Smear cursor when switching buffers or windows.
			smear_between_buffers = true,

			-- Smear cursor when moving within line or to neighbor lines.
			-- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
			smear_between_neighbor_lines = true,

			-- Draw the smear in buffer space instead of screen space when scrolling
			scroll_buffer_space = true,

			-- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
			-- Smears will blend better on all backgrounds.
			legacy_computing_symbols_support = false,

			-- Smear cursor in insert mode.
			-- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
			smear_insert_mode = true,
		},
	},
	{
		"echasnovski/mini.cursorword",
		version = "*",
		opts = { delay = 100 },
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			multiwindow = false, -- Enable multiwindow support.
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to show for a single context
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 20, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		},
	},
}
