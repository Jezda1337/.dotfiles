local M = {}
local lspconfig = require("lspconfig")

function M.deno_ls(compabilities, on_attach)
	lspconfig.denols.setup({
		on_attach = on_attach.on_attach,
		compabilities = compabilities,
		root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
	})
end

return M
