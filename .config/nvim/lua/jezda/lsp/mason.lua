local status, mason = pcall(require, "mason")
if not status then
	return
end

mason.setup({})
require("mason-null-ls").setup({
	ensure_installed = { "stylua", "prettier", "eslint_d", "goimports", "shfmt" },
	automatic_setup = true,
})

require("mason-lspconfig").setup({})
