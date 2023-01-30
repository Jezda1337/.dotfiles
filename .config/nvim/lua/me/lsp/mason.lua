local status, mason = pcall(require, "mason")
if not status then
	return
end

mason.setup({})

require("mason-null-ls").setup({
	ensure_installed = {
		"stylua",
		"prettier",
		"eslint_d",
		"gopls",
		"goimports",
		"shfmt",
		"clangd",
		"sumneko_lua",
		"tsserver",
		"pyright",
	},
	automatic_setup = true,
})

require("mason-lspconfig").setup({})
