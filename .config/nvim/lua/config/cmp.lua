local icons = require("config.icons")
local source_mapping = {
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	buffer = "[Buffer]",
	path = "[Path]",
	luasnip = "[Snip]",
}
return {
	expandable_indicator = true,
	fields = { "kind", "abbr", "menu" },
	format = function(entry, vim_item)
		--   require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

		local source = entry.source.name
		local kind = vim_item.kind

		if source == "html-css" then
			source_mapping["html-css"] = "[" .. entry.completion_item.provider .. "]" or "[html-css]"
		end

		vim_item.kind = (icons[kind] or "?") .. " "
		vim_item.menu = source_mapping[entry.source.name]

		local strings = vim.split(vim_item.kind, "%s+", { trimempty = true })
		vim_item.kind = " " .. string.format("%s │", strings[1], strings[2]) .. " "

		return vim_item
	end,
}
