local M = {}
local lspconfig = require("lspconfig")

function M.emmet_ls(capabilities, on_attach)
	lspconfig.emmet_ls.setup({
		on_attach = on_attach.on_attach,
		capabilities = capabilities,
		init_options = {
			html = {
				options = {
					-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
					["bem.enabled"] = true,
				},
			},
		},
	})
end

return M
