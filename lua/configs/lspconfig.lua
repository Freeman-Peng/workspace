local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local map = vim.keymap.set

local custom_map = function(bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end
	map("n", "<F1>", ":Telescope lsp_document_symbols<CR>", opts("show current symbols"))
	map("n", "<leader>ds", ":Telescope lsp_document_symbols<CR>", opts("show current symbols"))
	map("n", "<leader>q", ":Telescope diagnostics<CR>", opts("show diagnostics window"))
	map("n", "]d", vim.diagnostic.goto_next, opts("goto prev dignositc"))
	map("n", "[d", vim.diagnostic.goto_prev, opts("goto prev dignositc"))
	map("n", "<leader>lf", vim.diagnostic.open_float, opts("show float diagnostic"))
	map("n", "gr", ":Telescope lsp_references<CR>", opts("show reference"))
	map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
	map("n", "gd", ":Telescope lsp_definitions<CR>", opts("Go to declaration"))
end

local settings = {
	"lua_ls",
	"html",
	"cssls",
	"cmake",
	"gopls",
	"jdtls",
	"rust_analyzer",
	"emmet_ls",
	"volar",
	"tailwindcss",
	tsserver = {
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location = require("mason-registry").get_package("vue-language-server"):get_install_path()
						.. "/node_modules/@vue/language-server",
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
		},
	},
}

-- lsps with default config
for k, v in pairs(settings) do
	local opts = {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			custom_map(bufnr)
			if client.supports_method("textDocument/signatureHelp") then
				vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
					group = vim.api.nvim_create_augroup("LspSignature", {}),
					callback = function()
						vim.lsp.buf.signature_help()
					end,
					buffer = bufnr,
				})
			end
		end,
		capabilities = capabilities,
	}

	if type(v) == "table" then
		opts = vim.tbl_deep_extend("keep", opts, v)
	end
	-- assert(false, vim.inspect(opts))

	if type(k) == "string" then
		lspconfig[k].setup(opts)
	elseif type(v) == "string" then
		lspconfig[v].setup(opts)
	end
end
