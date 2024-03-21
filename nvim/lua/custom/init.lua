vim.env.TERM = "alacritty"
vim.opt.mouse = ""
vim.opt.exrc = true
vim.g.toggle_theme_icon = ""
vim.diagnostic.config {
  float = { border = "rounded" },
}

local custom_auto_group = vim.api.nvim_create_augroup("custom_grp", { clear = false })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  group = custom_auto_group,
  callback = function()
    local path = require "plenary.path"
    local fullPath = path:new(vim.fn.expand "~/.cache/bak")
    if vim.api.nvim_buf_get_name(0) == "" then
      fullPath = fullPath:joinpath(vim.fn.getcwd())
    else
      fullPath = fullPath:joinpath(path:new(vim.api.nvim_buf_get_name(0)):parent())
    end
    if not path:new(fullPath):exists() then
      path:new(fullPath):mkdir { parents = true }
    end
    vim.opt_local.backup = true
    vim.opt_local.backupdir = { fullPath:absolute() }
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "cpp" },
  group = custom_auto_group,
  callback = function()
    vim.api.nvim_set_keymap("n", "<F12>", "", {
      nowait = true,
      desc = "build",
      callback = function()
        vim.cmd "make"
      end,
    })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  group = custom_auto_group,
  callback = function()
    vim.api.nvim_set_keymap("n", "<F12>", "", {
      nowait = true,
      desc = "preview markdown",
      callback = function()
        vim.cmd "MarkdownPreview"
      end,
    })
  end,
})
