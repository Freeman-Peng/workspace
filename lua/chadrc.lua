-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "doomchad",
  lsp_semantic_tokens = true,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  tabufline = {
    overriden_modules = function()
      return {
        buttons = function()
          return ""
        end,
      }
    end,
  }
}

return M
