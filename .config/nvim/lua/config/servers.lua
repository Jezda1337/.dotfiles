local M = {}

-- If you are using mason.nvim, you can get the ts_plugin_path like this
-- local mason_registry = require("mason-registry")
-- local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
-- 	.. "/node_modules/@vue/language-server"

M.servers = {
	lua_ls = {},
	vuels = {},
	tsserver = {},
	volar = {},
	gopls = {},
	astro = {},
	tailwindcss = {},
	bashls = {},
	html = {},
	cssls = {},
	eslint_d = {},
	emmet_language_server = {},
	jsonls = {},
	marksman = {},
	pyright = {},
	rust_analyzer = {},
	svelte = {},
}

M.formatters = {
	"prettier",
	"prettierd",
	"stylua",
	"goimports",
	"shfmt",
	"eslint",
}

return M
