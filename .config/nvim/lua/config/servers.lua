local M = {}

M.servers = {
	lua_ls = {},
	volar = {},
	vuels = {},
	tsserver = {},
	gopls = {},
	astro = {},
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
