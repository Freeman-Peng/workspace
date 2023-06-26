local M = {}

M.general = {
  n = {
    ["<leader>ts"] = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
      "find workspace symbols",
      opts = { nowait = true },
    },
    ["<leader>ds"] = {
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      "lsp references",
    },
    ["<F1>"] = {
      function()
        if vim.lsp.buf.document_symbol then
          vim.cmd "Telescope lsp_document_symbols"
        else
          vim.cmd "Vista!!"
        end
      end,
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
