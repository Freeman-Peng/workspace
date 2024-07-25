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

  vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
  vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
  vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

  vim.fn.sign_define(
    "DapBreakpoint",
    { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
  )
  vim.fn.sign_define(
    "DapBreakpointCondition",
    { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
  )
  vim.fn.sign_define(
    "DapBreakpointRejected",
    { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
  )
  vim.fn.sign_define(
    "DapLogPoint",
    { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
  )
  vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
end

M.filetypes = function()
  local ft = {}
  for k, _ in pairs(M.opts) do
    table.insert(ft, k)
  end
  return ft
end

return M
