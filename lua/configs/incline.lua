local helpers = require("incline.helpers")
local navic = require("nvim-navic")
local devicons = require("nvim-web-devicons")
require("incline").setup({
	window = {
		padding = 0,
		margin = { horizontal = 0, vertical = 0 },
	},
	render = function(props)
		local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
		local ft_icon, ft_color = devicons.get_icon_color(filename)
		local navic_data = navic.get_data(props.buf) or {}
		if #navic_data == 0 then
			return {}
		end
		local res = {
			ft_icon and { " ", ft_icon, "  ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
			" ",
			guibg = "#44406e",
		}
		if props.focused then
			for _, item in ipairs(navic_data) do
				table.insert(res, {
					{ item.icon, group = "NavicIcons" .. item.type },
					{ item.name, group = "NavicText" },
					{ " > ", group = "NavicSeparator" },
				})
			end
			local last = res[#res]
			res[#res] = { last[1], last[2] }
		end
		table.insert(res, " ")
		return res
	end,
})
