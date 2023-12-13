-- First read our docs (completely) then check the example_config repo

local M = {}

M.plugins = "custom.plugins"

M.ui = {
  theme = "doomchad",
  lsp_semantic_tokens = true, -- needs nvim v0.9, just adds highlight groups for lsp semantic tokens
  hl_override = {
    Comment = {
      italic = true,
    },
  },
  tabufline = {
    overriden_modules = function()
      return {
        buttons = function()
          return ""
        end,
      }
    end,
  },
}

M.mappings = require "custom.mappings"

return M
