local M = {}
local lspconfig = require("lspconfig")
local util = lspconfig.util

function M.tailwind_ls(capabilities, on_attach)
	lspconfig.tailwindcss.setup({
		on_attach = on_attach.on_attach,
		capabilities = capabilities,
		root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.ts"),
	})
end

return M
