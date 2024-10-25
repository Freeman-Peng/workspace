-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  lsp_semantic_tokens = true,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  tabufline = {
    order = { "treeOffset", "buffers", "tabs" },
  },
  cmp = {
    format_colors = {
      tailwind = true,
    },
  },
}

M.base46 = {
  theme = "doomchad",
}

return M
