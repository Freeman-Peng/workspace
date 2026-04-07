local version = vim.version()
if not (version.minor >= 11 and version.patch >= 6) then
  error "nvim-lspconfig may not support current version"
end

require "lspconfig"
local M = {}

local map = vim.keymap.set
local navic = require "nvim-navic"

local settings = {
  "html",
  "cssls",
  "cmake",
  "gopls",
  "jdtls",
  "rust_analyzer",
  "emmet_ls",
  "tailwindcss",
  "csharp_ls",
  gradle_ls = {
    filetypes = { "gradle", "groovy", "kotlin" },
    allowParallelRun = true,
  },
  ts_ls = {
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = vim.fs.joinpath(
            vim.fn.stdpath "data",
            "mason",
            "packages",
            "vue-language-server",
            "node_modules",
            "@vue",
            "language-server"
          ),
          languages = { "vue" },
        },
      },
    },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
    },
  },
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            enable = true,
            maxLineLength = 120,
          },
        },
      },
    },
  },
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  clangd = {
    cmd = {
      "clangd",
      "--completion-style=detailed",
      "--pch-storage=memory",
      "-j",
      "4",
    },
  },
  lua_ls = {
    settings = {
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
      },
    },
  },
}

M.on_attach = function(client, bufnr, lsp_name)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  if client.supports_method "textDocument/signatureHelp" then
    vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
      group = vim.api.nvim_create_augroup("LspSignature", {}),
      callback = function()
        vim.lsp.buf.signature_help()
      end,
      buffer = bufnr,
    })
  end

  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<F1>", ":Telescope lsp_document_symbols<CR>", opts "show current symbols")
  map("n", "<leader>ds", function()
    require("telescope.builtin").lsp_document_symbols {
      symbol_width = 0.6,
      symbol_type_width = 0.1,
      fname_width = 0.3,
    }
  end, opts "show current symbols")
  map("n", "<leader>q", ":Telescope diagnostics<CR>", opts "show diagnostics window")
  map("n", "]d", function()
    vim.diagnostic.jump { count = 1 }
  end, opts "goto prev dignositc")
  map("n", "[d", function()
    vim.diagnostic.jump { count = -1 }
  end, opts "goto prev dignositc")
  map("n", "<leader>lf", vim.diagnostic.open_float, opts "show float diagnostic")
  map("n", "gr", ":Telescope lsp_references<CR>", opts "show reference")

  map("n", "gd", ":Telescope lsp_definitions<CR>", opts "Go to declaration")
  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

  map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  if lsp_name == "clangd" then
    map("n", "<leader>w", ":LspClangdSwitchSourceHeader<CR>", opts "Go to declaration")
  end
end

M.on_init = function(client, _)
  -- if client.supports_method("textDocument/semanticTokens") then
  -- 	client.server_capabilities.semanticTokensProvider = nil
  -- end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.setup = function()
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  for k, v in pairs(settings) do
    local name = type(k) == "string" and k or v

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        M.on_attach(client, args.buf, name)
      end,
    })

    if type(v) ~= "table" then
      v = {}
    end

    vim.lsp.config(name, v)
    vim.lsp.enable(name)
  end
end

return M
