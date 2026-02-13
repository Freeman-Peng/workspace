local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

		if not vim.g.ui_entered and args.event == "UIEnter" then
			vim.g.ui_entered = true
		end

		if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
			vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
			vim.api.nvim_del_augroup_by_name("NvFilePost")

			vim.schedule(function()
				vim.api.nvim_exec_autocmds("FileType", {})

				if vim.g.editorconfig then
					require("editorconfig").config(args.buf)
				end
			end)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(ev)
		if string.match(ev.file, "min.js$") or string.match(ev.file, ".mjs$") then
			return
		end
		pcall(vim.treesitter.start)
	end,
})

local create_cmd = vim.api.nvim_create_user_command

create_cmd("TSInstallAll", function()
	local spec = require("lazy.core.config").plugins["nvim-treesitter"]
	local opts = type(spec.opts) == "table" and spec.opts or {}
	require("nvim-treesitter").install(opts.ensure_installed)
end, {})

-- custom
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function()
		local path = vim.fn.expand("%:p:h")
		if path == "" then
			path = vim.fn.getcwd()
		end
		local full_path = vim.fn.stdpath("state") .. "/backup" .. path
		if not vim.fn.filereadable(full_path) then
			vim.fn.mkdir(full_path, "pR")
		end
		vim.o.backupdir = full_path
	end,
})

-- autocmds
-- local custom_auto_group = vim.api.nvim_create_augroup("custom_grp", { clear = false })

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "c", "cpp" },
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "yaml" },
	callback = function()
		vim.cmd("compiler! make")
		vim.b.current_compiler = "make"
		vim.g.current_compiler = "make"
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*.mjs", "*.min.js" }, -- add large file extensions
	callback = function()
		vim.treesitter.stop()
	end,
})
