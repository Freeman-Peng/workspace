require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
vim.o.exrc = true

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
map("n", "<leader>ce", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { end_row + 1, 0 })
    vim.api.nvim_feedkeys("_", "n", true)
  end
end, { desc = "blankline jump to current context" })
