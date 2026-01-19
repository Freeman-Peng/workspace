local M = {}
local map = vim.keymap.set

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
					location = vim.fn.expand("$MASON/packages/vue-language-server//node_modules/@vue/language-server"),
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
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
					vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
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

	if client.supports_method("textDocument/signatureHelp") then
		vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
			group = vim.api.nvim_create_augroup("LspSignature", {}),
			callback = function()
				vim.lsp.buf.signature_help()
			end,
			buffer = bufnr,
		})
	end

	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))

	map("n", "<F1>", ":Telescope lsp_document_symbols<CR>", opts("show current symbols"))
	map("n", "<leader>ds", ":Telescope lsp_document_symbols<CR>", opts("show current symbols"))
	map("n", "<leader>q", ":Telescope diagnostics<CR>", opts("show diagnostics window"))
	map("n", "]d", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts("goto prev dignositc"))
	map("n", "[d", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts("goto prev dignositc"))
	map("n", "<leader>lf", vim.diagnostic.open_float, opts("show float diagnostic"))
	map("n", "gr", ":Telescope lsp_references<CR>", opts("show reference"))

	map("n", "gd", ":Telescope lsp_definitions<CR>", opts("Go to declaration"))
	map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
	map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))

	map("n", "<leader>ra", require("nvchad.lsp.renamer"), opts("NvRenamer"))

	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))

	if lsp_name == "clangd" then
		map("n", "<leader>w", ":LspClangdSwitchSourceHeader<CR>", opts("Go to declaration"))
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

M.defaults = function()
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

		if vim.lsp.config then
			if type(v) == "table" then
				vim.lsp.config(name, v)
			end
			vim.lsp.enable(name)
		else
			local opts = {
				capabilities = M.capabilities,
				on_init = M.on_init,
			}
			if type(v) == "table" then
				opts = vim.tbl_deep_extend("keep", opts, v)
			end

			require("lspconfig")[name].setup(opts)
		end
	end
end

return M
