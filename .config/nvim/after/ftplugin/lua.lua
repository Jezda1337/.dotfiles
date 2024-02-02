local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.start({
	name = "lua-language-server",
	cmd = { "lua-language-server" },
	root_dir = vim.fs.dirname(vim.fs.find({ "init.lua" }, { upward = true })[1]),
	capabilities = capabilities,
	on_attach = require("plugins.utils.on_attach").on_attach,
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
	},
})
