vim.opt.mouse = ""

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    local path = require "plenary.path"
    vim.opt_local.backupdir:remove { "." }
    local fullPath =
      path:new(vim.opt_local.backupdir:get(0)):joinpath(path:new(vim.api.nvim_buf_get_name(0)):parent()):absolute()
    if not path:new(fullPath):exists() then
      path:new(fullPath):mkdir { parents = true }
    end
    vim.opt_local.backup = true
    vim.opt_local.backupdir = { fullPath }
  end,
})
