local dap = require "dap"
local binpath = vim.fn.stdpath "data" .. "/mason/bin"

local M = {
  opts = {
    python = {
      adapter = {
        type = "executable",
        command = binpath .. "/debugpy-adapter",
        args = {},
      },
      config = {
        {
          type = "python",
          request = "launch",
          name = "Launch Python",
          program = "${file}",
          pythonPath = function()
            return "/usr/bin/python"
          end,
        },
      },
    },
  },
}

M.setup = function()
  for k, v in pairs(M.opts) do
    dap.adapters[k] = v.adapter
    dap.configurations[k] = vim.deepcopy(v.config)
  end
end

M.filetypes = function()
  local ft = {}
  for k, _ in pairs(M.opts) do
    table.insert(ft, k)
  end
  return ft
end

return M
