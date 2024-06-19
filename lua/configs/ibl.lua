local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

local function setup()
  dofile(vim.g.base46_cache .. "blankline")

  local hooks = require "ibl.hooks"
  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  require("ibl").setup {
    indent = {
      char = {
        "▏",
        "▎",
        "▍",
        "▌",
        "▋",
        "▊",
        "▉",
        "█",
      },
      smart_indent_cap = true,
    },
    scope = {
      enabled = true,
      show_start = true,
      show_exact_scope = true,
      highlight = { "Normal" },
    },
  }

  dofile(vim.g.base46_cache .. "blankline")
end

setup()
