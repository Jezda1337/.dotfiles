local M = {}
local HOME = os.getenv("HOME")

function M.vue_ls(capabilities, on_attach)
	require("lspconfig").volar.setup({
		on_attach = on_attach.on_attach,
		capabilities = capabilities,
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
		init_options = {
			typescript = {
				tsdk = HOME .. "/.nvm/versions/node/v19.6.0/lib/node_modules/typescript/lib",
			},
		},
	})
end

return M
