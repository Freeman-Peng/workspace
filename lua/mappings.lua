require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

map({ "n", "v" }, "j", "gj")
map({ "n", "v" }, "k", "gk")
map({ "n" }, "<C-c>", function()
  local ok, dap = pcall(require, "dap")
  if ok and dap.session() ~= nil then
    dap.terminate()
  else
    vim.cmd "%y+"
  end
end)
--
