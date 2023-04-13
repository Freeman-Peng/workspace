local M = {}

M.general = {
  n = {
    ["<leader>ts"] = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
      "find workspace symbols",
      opts = { nowait = true },
    },
    ["<F1>"] = {
      "<cmd>Vista!!<CR>",
      "open symbol window",
      opts = { nowait = true },
    },
    ["<F12>"] = {
      "<cmd>MarkdownPreview<cr>",
      "preview markdown",
      opts = { nowait = true },
    },
    ["gr"] = {
      function()
        require("telescope.builtin").lsp_references()
      end,
      "lsp references",
    },
    ["gd"] = {
      function()
        require("telescope.builtin").lsp_definitions()
      end,
      "lsp references",
    },
  },
}

return M
