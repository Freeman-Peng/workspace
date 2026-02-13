local opts = require("nvchad.configs.gitsigns")

opts.numhl = true
opts.on_attach = function(bufnr)
	local gitsigns = require("gitsigns")

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	map("n", "]c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "]c", bang = true })
		else
			gitsigns.nav_hunk("next")
		end
	end, { desc = "next hunk" })

	map("n", "[c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[c", bang = true })
		else
			gitsigns.nav_hunk("prev")
		end
	end, { desc = "prev hunk" })

	-- Actions
	map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "stage hunk" })
	map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "reset hunk" })

	map("v", "<leader>hs", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "stage hunk for current line" })

	map("v", "<leader>hr", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }, { desc = "reset hunk for current link" })
	end)

	map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "stage buffer" })
	map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "reset buffer" })
	map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "preview hunk" })
	map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "preview hunk inline" })
	map("n", "<leader>hd", gitsigns.diffthis, { desc = "show current file diff" })

	map("n", "<leader>hD", function()
		gitsigns.diffthis("~")
	end, { desc = "diff" })

	map("n", "<leader>hQ", function()
		gitsigns.setqflist("all")
	end, { desc = "quicklist all files hunk" })
	map("n", "<leader>hq", gitsigns.setqflist, { desc = "quicklist current file hunk" })

	-- Toggles
	map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "toggle current blame" })
	map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "toggle word diff" })

	-- Text object
	map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "select hunk" })
end

return opts
