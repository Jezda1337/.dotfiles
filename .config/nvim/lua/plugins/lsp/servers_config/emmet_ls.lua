local M = {}
local lspconfig = require("lspconfig")

function M.emmet_ls(on_attach, capabilities)
	lspconfig.emmet_ls.setup({
		-- on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"css",
			"eruby",
			"html",
			"javascript",
			"javascriptreact",
			"less",
			"sass",
			"scss",
			"svelte",
			"pug",
			"typescriptreact",
			"vue",
		},
		init_options = {
			html = {
				options = {
					-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
					["bem.enabled"] = true,
					["comment.enabled"] = true,
				},
			},
		},
	})
end

return M
