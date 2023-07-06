-- First read our docs (completely) then check the example_config repo

local M = {}

M.plugins = "custom.plugins"

M.ui = {
  theme = "doomchad",
  hl_override = {
    Comment = {
      italic = true,
    },
  },
}

M.mappings = require "custom.mappings"

return M
