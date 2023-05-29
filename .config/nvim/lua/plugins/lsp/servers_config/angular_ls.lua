local M = {}

local lspconfig = require("lspconfig")
function M.angular_ls(capabilities, on_attach)
	lspconfig.angularls.setup({
		on_attach = on_attach.on_attach,
		capabilities = capabilities,
	})
end

return M
