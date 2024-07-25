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
          env = {
            qt = "pyqt5",
          },
        },
      },
    },
  },
}

local function add_custom_repl_cmd()
  local repl = require "dap.repl"
  repl.commands = vim.tbl_extend("force", repl.commands, {
    -- Add a new alias for the existing .exit command
    exit = { "exit", ".exit", ".q" },
    frames = { "frames", ".frames", ".bt" },
    -- Add your own commands; run `.echo hello world` to invoke
    -- this function with the text "hello world"
    custom_commands = {
      [".echo"] = function(text)
        dap.repl.append(text)
      end,
      -- Hook up a new command to an existing dap function
      [".restart"] = dap.restart,
      [".s"] = dap.step_over,
      [".si"] = dap.step_into,
      [".so"] = dap.step_out,
    },
  })
end

local function add_keymap()
  local maps = {
    -- <S-F5>
    ["<F17>"] = function()
      if dap.session() == nil then
        dap.list_breakpoints()
        if #vim.fn.getqflist() == 0 then
          dap.toggle_breakpoint()
        end
        dap.continue()
      else
        dap.run_to_cursor()
      end
    end,
    ["<F5>"] = dap.continue,
    ["<F10>"] = dap.step_over,
    ["<F11>"] = dap.step_into,
    ["<F23>"] = dap.step_out,
    ["<leader>B"] = dap.toggle_breakpoint,
  }

  vim.api.nvim_create_autocmd({ "Filetype" }, {
    pattern = M.filetypes(),
    callback = function()
      for k, v in pairs(maps) do
        vim.keymap.set({ "n" }, k, v, { buffer = true })
      end
    end,
  })
end

local function custom_ui()
  vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
  vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
  vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

  vim.fn.sign_define(
    "DapBreakpoint",
    { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
  )
  vim.fn.sign_define(
    "DapBreakpointCondition",
    { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
  )
  vim.fn.sign_define(
    "DapBreakpointRejected",
    { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
  )
  vim.fn.sign_define(
    "DapLogPoint",
    { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
  )
  vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
end

M.setup = function()
  for k, v in pairs(M.opts) do
    dap.adapters[k] = v.adapter
    dap.configurations[k] = vim.deepcopy(v.config)
  end
  custom_ui()
  add_custom_repl_cmd()
  add_keymap()
end

M.filetypes = function()
  local ft = {}
  for k, _ in pairs(M.opts) do
    table.insert(ft, k)
  end
  return ft
end

return M
