local M = {}

local on_attach = require("me.lsp.on_attach").on_attach
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.config = {
	on_attach = on_attach,
	capabilities = capabilities,
}

return M
