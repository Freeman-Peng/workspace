return {
	{
		"stevearc/conform.nvim",
		-- enabled = false,
		ft = require("configs.conform").ft,
		opts = require("configs.conform").opts,
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
		event = "User FilePost",
		config = function()
			require("configs.lspconfig").defaults()
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
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "Marskey/telescope-sg" },
			{ "debugloop/telescope-undo.nvim" },
		},
		keys = {
			{ "<leader>u", "<cmd>Telescope undo<CR>", desc = "open telescope undo extensions" },
		},
	end,
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
			trim_scope = "inner", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 20, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		},
	},
	{
		"Wansmer/treesj",
		keys = {
			{ "<leader>j", "<cmd>TSJToggle<cr>", desc = "toggle blocks of code splitting/joining" },
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			use_default_keymaps = true,
			---@type boolean Node with syntax error will not be formatted
			check_syntax_error = true,
			---If line after join will be longer than max value,
			---@type number If line after join will be longer than max value, node will not be formatted
			max_join_length = 120,
			---Cursor behavior:
			---hold - cursor follows the node/place on which it was called
			---start - cursor jumps to the first symbol of the node being formatted
			---end - cursor jumps to the last symbol of the node being formatted
			---@type 'hold'|'start'|'end'
			cursor_behavior = "hold",
			---@type boolean Notify about possible problems or not
			notify = true,
			---@type boolean Use `dot` for repeat action
			dot_repeat = true,
			---@type nil|function Callback for treesj error handler. func (err_text, level, ...other_text)
			on_error = nil,
			---@type table Presets for languages
			-- langs = {}, -- See the default presets in lua/treesj/langs
		},
		cmd = { "TSJToggle" },
	},
	{
		"dhananjaylatkar/cscope_maps.nvim",
		cmd = { "Cscope", "Cs" },
		opts = {
			skip_input_prompt = true,
			cscope = {
				db_file = "GTAGS",
				exec = "gtags-cscope",
				picker = "telescope",
			},
		},
	},
	{ "nvim-autopairs", event = "InsertEnter", config = true },
	{ import = "nvchad.blink.lazyspec" },
	{
		"saghen/blink.cmp",
		opts = function()
			local opts = require("nvchad.blink.config")
			opts.keymap["<Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback",
			}
			return opts
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		dependencies = {
			"junegunn/fzf",
		},
		ft = "qf",
		-- opts = {
		-- 	filter = {
		-- 		fzf = {
		-- 			extra_opts = { '--bind', 'ctrl-o:toggle-all', '--delimiter', '│' }
		-- 		}
		-- 	}
		-- }
	},
}
