local M = {}

local function on_list(options)
  vim.fn.setqflist({}, " ", options)
  if #options.items > 1 then
    require("telescope.builtin").quickfix()
  else
    vim.api.nvim_command "cfirst"
  end
end

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
        vim.lsp.buf.references(nil, { on_list = on_list })
      end,
      "lsp references",
    },
    ["gd"] = {
      function()
        vim.lsp.buf.definition { on_list = on_list }
      end,
      "lsp references",
    },
  },
}

return M
