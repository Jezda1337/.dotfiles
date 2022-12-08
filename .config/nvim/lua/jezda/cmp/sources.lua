local M = {}

M.sources = {
	{ name = "nvim_lsp", max_item_count = 10 },
	{ name = "nvim_lua", max_item_count = 10 },
	{ name = "luasnip", max_item_count = 5, keyword_length = 2 },
	{ name = "nvim_lsp_signature_help" },
	{ name = "buffer", keyword_length = 5 },
}

return M
