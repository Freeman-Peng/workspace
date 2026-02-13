local opts = require("nvchad.configs.telescope")
local M = {}

opts.extensions_list = { unpack(opts.extensions_list), "ast_grep", "undo" }
opts.defaults.preview = {
	use_ft_detect = true,
	mime_hook = function(filepath, bufnr, opts)
		local check_ext = function(path, ext)
			local split_path = vim.split(path:lower(), ".", { plain = true })
			local extension = split_path[#split_path]
			return vim.tbl_contains(ext, extension)
		end

		if check_ext(filepath, { "png", "jpg", "jpeg", "webp", "gif" }) then
			local term = vim.api.nvim_open_term(bufnr, {})
			local function send_output(_, data, _)
				for _, d in ipairs(data) do
					vim.api.nvim_chan_send(term, d .. "\r\n")
				end
			end
			vim.fn.jobstart({
				"chafa",
				"-c",
				"full",
				"-s",
				vim.api.nvim_win_get_width(opts.winid),
				filepath, -- Terminal image viewer command
			}, { on_stdout = send_output, stdout_buffered = true, pty = true })
		-- elseif check_ext(filepath, { "ts", "tsx", "jsx" }) then
		else
			require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
		end
	end,
}

opts.defaults.layout_config.vertical = { width = 0.88 }
opts.defaults.layout_strategy = "vertical"

require("telescope").setup(opts)
require("telescope").load_extension("ui-select")
require("telescope").load_extension("ast_grep")

local is_inside_work_tree = {}

local project_files = function()
	local opts = {} -- define here if you want to define something

	local cwd = vim.fn.getcwd()
	if is_inside_work_tree[cwd] == nil then
		vim.fn.system("git rev-parse --is-inside-work-tree")
		is_inside_work_tree[cwd] = vim.v.shell_error == 0
	end

	if is_inside_work_tree[cwd] then
		require("telescope.builtin").git_files(opts)
	else
		require("telescope.builtin").find_files(opts)
	end
end
vim.api.nvim_set_keymap("n", "<Leader>ff", "", { noremap = true, silent = true, callback = project_files })

local live_grep_from_project_git_root = function()
	local function is_git_repo()
		vim.fn.system("git rev-parse --is-inside-work-tree")

		return vim.v.shell_error == 0
	end

	local function get_git_root()
		local dot_git_path = vim.fn.finddir(".git", ".;")
		return vim.fn.fnamemodify(dot_git_path, ":h")
	end

	local opts = {}

	if is_git_repo() then
		opts = {
			cwd = get_git_root(),
		}
	end

	require("telescope.builtin").live_grep(opts)
end

vim.api.nvim_set_keymap(
	"n",
	"<Leader>fw",
	"",
	{ noremap = true, silent = true, callback = live_grep_from_project_git_root }
)

return M
