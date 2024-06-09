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
	emmet_language_server = {},
	jsonls = {},
	marksman = {},
	pyright = {},
	rust_analyzer = {},
	-- efm = {},
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
