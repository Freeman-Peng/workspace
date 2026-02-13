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
