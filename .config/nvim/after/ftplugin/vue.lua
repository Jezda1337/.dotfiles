local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.start({
	name = "Volar",
	cmd = { "vue-language-server", "--stdio" },
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
	capabilities = capabilities,
	init_options = {
		typescript = {
			tsdk = "/Users/radojejezdic/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib",
		},
		preferences = {
			disableSuggestions = true,
		},
		languageFeatures = {
			implementation = true,
			references = true,
			definition = true,
			typeDefinition = true,
			callHierarchy = true,
			hover = true,
			rename = true,
			renameFileRefactoring = true,
			signatureHelp = true,
			codeAction = true,
			workspaceSymbol = true,
			diagnostics = true,
			semanticTokens = true,
			completion = {
				defaultTagNameCase = "both",
				defaultAttrNameCase = "kebabCase",
				getDocumentNameCasesRequest = false,
				getDocumentSelectionRequest = false,
			},
		},
	},
})
