local M = {}
local dap, dapui = require "dap", require "dapui"

local function toggle_mouse()
  if vim.o.mouse == "" then
    vim.o.mouse = "a"
    vim.o.mousemodel = "extend"
  else
    vim.o.mouse = ""
  end
end

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
  toggle_mouse()
end

dap.listeners.before.launch.dapui_config = function()
  dapui.open()
  toggle_mouse()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
  -- toggle_mouse not work ??
  vim.o.mouse = ""
end
dap.listeners.before.event_exited.dapui_config = function()
  toggle_mouse()
  -- toggle_mouse not work ??
  vim.o.mouse = ""
end

M.setup = function(opts)
  opts = opts
    or {
      layouts = {
        {
          elements = {
            {
              id = "repl",
              size = 0.75,
            },
            {
              id = "console",
              size = 0.25,
            },
          },
          position = "bottom",
          size = 10,
        },
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
            {
              id = "watches",
              size = 0.25,
            },
          },
          position = "right",
          size = 40,
        },
      },
    }
  dapui.setup(opts)
end

return M
