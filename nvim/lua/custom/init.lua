vim.opt.mouse = ""
vim.opt.exrc = true

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*" },
	callback = function()
		local path = require("plenary.path")
		local fullPath = path:new(vim.fn.expand("~/.cache/bak"))
		if vim.api.nvim_buf_get_name(0) == "" then
			fullPath = fullPath:joinpath(vim.fn.getcwd())
		else
			fullPath = fullPath:joinpath(path:new(vim.api.nvim_buf_get_name(0)):parent())
		end
		-- if not path:new(fullPath):exists() then
		--   path:new(fullPath):mkdir({ parents = true })
		-- end
		vim.opt_local.backup = true
		vim.opt_local.backupdir = { fullPath:absolute() }
	end,
})
