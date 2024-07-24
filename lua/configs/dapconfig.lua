local dap = require "dap"
local binpath = vim.fn.stdpath "data" .. "/mason/bin"

dap.adapters.python = {
  type = "executable",
  command = binpath .. "/debugpy-adapter",
  args = {},
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch Python",
    program = "${file}",
    pythonPath = function()
      return "/usr/bin/python"
    end,
  },
}
