local M = {}
local lspconfig = require("lspconfig")

function M.emmet_ls(capabilities, on_attach)
	lspconfig.emmet_ls.setup({
		on_attach = on_attach.on_attach,
		capabilities = capabilities,
	})
end

return M
