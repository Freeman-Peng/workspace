local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local yapf = b.formatting.yapf
yapf.generator_opts = {
  command = "yapf",
  args = require("null-ls.helpers").range_formatting_args_factory({
    "--quiet",
    "--style",
    "{based_on_style: pep8, indent_width: 2}",
  }, "--lines", nil, { use_rows = true, delimiter = "-" }),
  to_stdin = true,
}
local sources = {

  -- webdev stuff
  b.formatting.prettier.with {
    filetypes = {
      "html",
      "markdown",
      "css",
      "scss",
      "json",
      "yaml",
      "typescriptreact",
      "typescript",
      "javascriptreact",
      "javascript",
      "less",
      "vue",
      "python",
    },
  },

  -- Lua
  b.formatting.stylua,

  -- Shell
  b.formatting.shfmt,
  -- b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- go
  b.formatting.gofmt,

  -- python
  b.formatting.yapf,

  -- protobuf
  b.diagnostics.protolint,
  b.formatting.protolint,

  -- c/cpp
  b.formatting.clang_format,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup {
  debug = false,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          if vim.lsp.buf_is_attached() and vim.lsp.protocol.CodeActionKind["SourceOrganizeImports"] ~= nil then
            vim.lsp.buf.code_action { context = { only = { "source.organizeImports" } }, apply = true }
          end
          vim.lsp.buf.format { async = false }
        end,
      })
    end
  end,
}
