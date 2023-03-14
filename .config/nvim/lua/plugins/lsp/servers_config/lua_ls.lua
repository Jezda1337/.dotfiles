local M = {}
-- local capabilities = vim.lsp.protocol.make_client_capabilities()

function M.lua_ls(capabilities, on_attach)
	require("lspconfig").lua_ls.setup({
	on_attach = on_attach.on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";", {}),
			},
			diagnostics = {
				globals = { "vim" },
			},
			telemetry = {
				enable = false,
			},
		},
		workspace = {
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
			},
		},
	}})
end


return M
