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
		enable = false,
		use_languagetree = true,
	},
	indent = { enable = true },
	incremental_selection = { enable = true },
}
