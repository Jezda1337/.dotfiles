local M = {}

M.sources = {
	{
		name = "nvim_lsp",

		-- filtering completion when we jump inside some property that have
		-- methods for example obj1.(something) wont
		-- show nonsense's
		entry_filter = function(entry, context)
			local kind = entry:get_kind()

			local line = context.cursor_line
			local col = context.cursor.col
			local char_before_cursor = string.sub(line, col - 1, col - 1)

			if char_before_cursor == "." then
				if kind == 2 or kind == 5 then
					return true
				else
					return false
				end
			else
				if string.match(line, "^%s*%w*$") then
					if kind == 3 or kind == 6 then
						return true
					else
						return false
					end
				end
			end

			return true
		end,

		max_item_count = 20,
		group_index = 1,
	},
	{ name = "nvim_lua", max_item_count = 10 },
	{ name = "luasnip", max_item_count = 5, keyword_length = 2 },
	{ name = "nvim_lsp_signature_help" },
	{ name = "buffer", keyword_length = 5 },
}

return M
