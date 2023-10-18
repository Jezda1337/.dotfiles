return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
	},
	config = function()
		require("neodev").setup() -- init neovim dev plugin must be init before lsp

		-- local function mrgtbls(t1, t2)
		-- 	for _, v in ipairs(t2) do
		-- 		table.insert(t1, v)
		-- 	end
		-- 	return t1
		-- end

		local signs = {
			Error = " ",
			Warn = " ",
			Info = " ",
			Hint = " ",
		}

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		vim.diagnostic.config({
			signs = true,
			severity_sort = true,
			virtual_text = {
				prefix = "🔥",
				source = true,
			},
		})

		local lsp = require("lspconfig")
		-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)

		capabilities.offsetEncoding = { "utf-16" }
		local servers = {
			"emmet_language_server",
			"tailwindcss",
			"jsonls",
			"prismals",
			"dockerls",
			"eslint",
			"marksman",
			"gopls",
			"angularls",
			"yamlls",
			"svelte",
			-- "volar",
		}

		for _, server in ipairs(servers) do
			if server == "gopls" then
				lsp[server].setup({
					capabilities = capabilities,
					on_attach = require("plugins.utils.on_attach").on_attach,
					settings = {
						gopls = {
							experimentalPostfixCompletions = true,
							analyses = {
								unusedparams = true,
								shadow = true,
							},
							staticcheck = true,
						},
					},
					init_options = {
						usePlaceholders = true,
					},
				})
			elseif server == "angularls" then
				local project_library_path =
					"/Users/radojejezdic/.nvm/versions/node/v20.1.0/lib/node_modules"
				local cmd = {
					"ngserver",
					"--stdio",
					"--tsProbeLocations",
					project_library_path,
					"--ngProbeLocations",
					project_library_path,
				}

				require("lspconfig").angularls.setup({
					capabilities = capabilities,
					on_attach = require("plugins.utils.on_attach").on_attach,
					cmd = cmd,
					on_new_config = function(new_config, new_root_dir)
						new_config.cmd = cmd
					end,
				})
			else
				lsp[server].setup({
					capabilities = capabilities,
					on_attach = require("plugins.utils.on_attach").on_attach,
				})
			end
		end
	end,
}
