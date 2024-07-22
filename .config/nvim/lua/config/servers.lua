local M = {}

-- If you are using mason.nvim, you can get the ts_plugin_path like this
-- local mason_registry = require("mason-registry")
-- local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
-- 	.. "/node_modules/@vue/language-server"

M.servers = {
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						---https://github.com/neovim/nvim-lspconfig/issues/2948#issuecomment-1871455900
						vim.env.VIMRUNTIME .. "/lua",
						"${3rd}/busted/library",
						"${3rd}/luv/library",
					},
				},
				codeLens = {
					enable = true,
				},
				hint = {
					enable = true,
				},
			},
		},
	},
	vuels = {
		single_file_support = false,
		settings = {
			---https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
			typescript = {
				tsserver = { log = vim.env.LSP_LOG_LEVEL == "TRACE" and "verbose" or "off" },
				---https://www.typescriptlang.org/docs/handbook/release-notes/typescript-4-0.html#smarter-auto-imports
				---https://github.com/yioneko/vtsls/blob/41ad8c9d3f9dbd122ce3259564f34d020b7d71d9/packages/service/configuration.schema.json#L779C29-L779C58
				preferences = { includePackageJsonAutoImports = "off" },
				---https://github.com/yioneko/vtsls/blob/41ad8c9d3f9dbd122ce3259564f34d020b7d71d9/packages/service/configuration.schema.json#L1025C17-L1025C43
				preferGoToSourceDefinition = true,
				inlayHints = {
					parameterNames = {
						enabled = "all",
					},
					parameterTypes = {
						enabled = true,
					},
					propertyDeclarationTypes = {
						enabled = true,
					},
					functionLikeReturnTypes = {
						enabled = true,
					},
					enumMemberValues = {
						enabled = true,
					},
				},
				referencesCodeLens = {
					enabled = true,
					showOnAllFunctions = true,
				},
				implementationsCodeLens = {
					enabled = true,
					showOnInterfaceMethods = true,
				},
			},
			vtsls = {
				autoUseWorkspaceTsdk = true,
				experimental = {
					completion = {
						enableServerSideFuzzyMatch = true,
					},
				},
			},
		},
	},
	tsserver = {
		init_options = {
			preferences = {
				includeCompletionsForModuleExports = false,
			},
			tsserver = {
				logVerbosity = vim.env.LSP_LOG_LEVEL == "TRACE" and "verbose" or "off",
				trace = vim.env.LSP_LOG_LEVEL == "TRACE" and "verbose" or "off",
			},
		},
		settings = {
			javascript = {
				implementationsCodeLens = { enabled = true },
				referencesCodeLens = {
					showOnAllFunctions = true,
					enabled = true,
				},
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = true,
				},
			},
			typescript = {
				implementationsCodeLens = { enabled = true },
				referencesCodeLens = {
					enabled = true,
					showOnAllFunctions = true,
				},
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = true,
				},
			},
		},
	},
	volar = {},
	gopls = {},
	astro = {},
	tailwindcss = {},
	bashls = {},
	html = {},
	cssls = {},
	eslint_d = {},
	emmet_language_server = {},
	jsonls = {},
	marksman = {},
	pyright = {},
	rust_analyzer = {},
	svelte = {},
}

M.formatters = {
	"prettier",
	"prettierd",
	"stylua",
	"goimports",
	"shfmt",
	"eslint",
}

return M
