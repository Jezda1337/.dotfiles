return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
	},
	config = function()
		require("neodev").setup() -- init neovim dev plugin must be init before lsp
		local util = require("lspconfig.util")

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
				prefix = signs.Warn,
				source = true,
			},
		})

		-- colors for background and text color in float window
		vim.cmd([[highlight NormalFloat guifg=white guibg=#000]])
		vim.cmd([[highlight FloatBorder guifg=white guibg=none]]) -- bg overflow the borders

		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded"
			opts.max_width = opts.max_width or 80 -- max width for the float window
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

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
			"tsserver",
			"cssls",
			-- "vuels", -- for vue 2
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
			elseif server == "tailwindcss" then
				require("lspconfig").tailwindcss.setup({
					capabilities = capabilities,
					on_attach = require("plugins.utils.on_attach").on_attach,
					root_dir = util.root_pattern(
						"tailwind.config.js",
						"tailwind.config.cjs",
						"tailwind.config.mjs",
						"tailwind.config.ts",
						"postcss.config.js",
						"postcss.config.cjs",
						"postcss.config.mjs",
						"postcss.config.ts"
					),
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
