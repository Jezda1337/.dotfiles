return {
	"williamboman/mason-lspconfig",
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				-- "prismals",
				"tailwindcss",
				"gopls",
				"html",
				"cssls",
				"astro",
				"emmet_language_server",
				"eslint",
				"marksman",
				"volar",
				-- "denols",
				-- "angularls",
				"vimls",
				-- "awk_ls",
				-- "yamlls",
				-- "efm",
			},
		})
	end,
}
