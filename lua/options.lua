require "nvchad.options"

-- add yours here!

local o = vim.o

-- o.cursorlineopt ='both' -- to enable cursorline!
o.mouse = ""
o.backup = true
o.backupskip = ""
o.updatetime = 250

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
