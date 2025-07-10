return {
	ensure_installed = {
		"vim",
		"lua",
		"vimdoc",

		-- data schema
		"json",

		-- static lang
		"c",
		"cpp",
		"glsl",

		-- web stuff
		"html",
		"css",
		"javascript",
		"typescript",
		"vue",
	},
	highlight = {
		disable = function(lang, buf)
			local max_filesize = 512 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		use_languagetree = true,
		indent = { enable = true },
		incremental_selection = { enable = true },
	},
}
