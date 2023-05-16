local M = {}
local HOME = os.getenv("HOME")

local util = require("lspconfig.util")

function M.vue_ls(capabilities, on_attach)
	require("lspconfig").volar.setup({
		-- root_dir = function()
		-- 	return vim.fs.dirname(vim.fs.find({ "nuxt.config.js", "app.vue" }, { upward = true })[1])
		-- end,
		root_dir = util.root_pattern({ "nuxt.config.js", "app.vue" }),
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
