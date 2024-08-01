require "nvchad.options"

-- add yours here!

local o = vim.o

-- o.cursorlineopt ='both' -- to enable cursorline!
o.mouse = ""
o.backup = true
o.backupskip = ""

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function()
    local path = vim.fn.expand "%:p:h"
    if path == "" then
      path = vim.fn.getcwd()
    end
    local full_path = vim.fn.stdpath "state" .. "/backup" .. path
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
