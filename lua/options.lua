require("nvchad.options")

-- add yours here!

local o = vim.o

-- o.cursorlineopt ='both' -- to enable cursorline!
o.mouse = ""
o.backup = true
o.backupskip = ""
o.updatetime = 250
o.expandtab = false
o.diffopt = "iwhite," .. o.diffopt
o.showbreak = "ͱ"

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
		o.backupdir = full_path
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

-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = { "*" },
--   callback = function()
--     local home = vim.fn.expand "~"
--     local path = vim.fn.expand "%:p:h"
--     if path == "" then
--       path = vim.fn.getcwd()
--     end
--
--     while not vim.fn.filereadable(path .. "/.nvim.lua") do
--       if home == path or path == "/" then
--         vim.api.nvim_err_writeln(path)
--         return
--       end
--       path = vim.fn.fnamemodify(path, ":h")
--     end
--     ok = pcall(require, path .. "/.nvim")
--   end,
-- })

-- for wsl
if vim.env.WSL2_GUI_APPS_ENABLED then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "/home/fpeng/.local/bin/win32yank.exe -i --crlf",
			["*"] = "/home/fpeng/.local/bin/win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "/home/fpeng/.local/bin/win32yank.exe -o --lf",
			["*"] = "home/fpeng/.local/bin/win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "yaml" },
	callback = function()
		vim.cmd("compiler! make")
		vim.b.current_compiler = "make"
		vim.g.current_compiler = "make"
	end,
})
