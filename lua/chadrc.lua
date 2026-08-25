-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	lsp_semantic_tokens = true,

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
	tabufline = {
		order = { "treeOffset", "buffers", "tabs" },
	},
	cmp = {
		format_colors = {
			tailwind = true,
		},
	},

	statusline = {
		theme = "default",
		separator_style = "default",
		order = { "mode", "f", "git", "%=", "lsp_msg", "%=", "lsp", "cwd", "xyz", "abc" },
		modules = {
			abc = function()
				return "hi"
			end,

			xyz = "hi",
			f = "%F",
		},
	},
}

M.base46 = {
	theme = "kanagawa",
}

return M
