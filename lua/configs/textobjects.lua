require("nvim-treesitter-textobjects").setup({
	select = {
		-- Automatically jump forward to textobj, similar to targets.vim
		lookahead = true,
		-- You can choose the select mode (default is charwise 'v')
		--
		-- Can also be a function which gets passed a table with the keys
		-- * query_string: eg '@function.inner'
		-- * method: eg 'v' or 'o'
		-- and should return the mode ('v', 'V', or '<c-v>') or a table
		-- mapping query_strings to modes.
		selection_modes = {
			["@parameter.outer"] = "v", -- charwise
			["@function.outer"] = "V", -- linewise
			-- ['@class.outer'] = '<c-v>', -- blockwise
		},
		-- If you set this to `true` (default is `false`) then any textobject is
		-- extended to include preceding or succeeding whitespace. Succeeding
		-- whitespace has priority in order to act similarly to eg the built-in
		-- `ap`.
		--
		-- Can also be a function which gets passed a table with the keys
		-- * query_string: eg '@function.inner'
		-- * selection_mode: eg 'v'
		-- and should return true of false
		include_surrounding_whitespace = false,
	},
	move = {
		set_jumps = true,
	},
})

local selectKeymaps = {
	["af"] = "@function.outer",
	["if"] = "@function.innter",

	["ac"] = "@class.outer",
	["ic"] = "@class.innter",
}

for k, v in pairs(selectKeymaps) do
	vim.keymap.set({ "x", "o" }, k, function()
		require("nvim-treesitter-textobjects.select").select_textobject(v, "textobjects")
	end)
end

vim.keymap.set({ "x", "o" }, "as", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
end)

local mapFunc = {
	["["] = require("nvim-treesitter-textobjects.move").goto_previous,
	["]"] = require("nvim-treesitter-textobjects.move").goto_next,
}

for key, f in pairs(mapFunc) do
	vim.keymap.set({ "x", "o", "n" }, key .. "f", function()
		f("@function.outer", "textobjects")
	end)

	vim.keymap.set({ "x", "o", "n" }, key .. "s", function()
		f("@local.scope", "locals")
	end)
end
