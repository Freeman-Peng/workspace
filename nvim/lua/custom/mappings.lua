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

M.lspconfig = {
  n = {
    ["<leader>ra"] = {
      function()
        require("nvchad_ui.renamer").open()
        require("cmp").setup.buffer { enabled = false }
      end,
      "LSP rename",
    },
  },
}

M.blankline = {
  n = {
    ["<leader>ce"] = {
      function()
        local ok, _, endp = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { endp, 0 })
          vim.cmd [[normal! _]]
        end
      end,

      "Jump to current context",
    },
  },
}

return M
