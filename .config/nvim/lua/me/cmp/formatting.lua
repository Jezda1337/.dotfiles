local M = {}

local config = {
	color_hint_width = 2,
	color_square_width = 2,
}

local icons = {
	Text = "  ",
	Method = "  ",
	Function = "  ",
	Constructor = "  ",
	Field = "  ",
	Variable = "  ",
	Class = "  ",
	Interface = "  ",
	Module = "  ",
	Property = "  ",
	Unit = "  ",
	Value = "  ",
	Enum = "  ",
	Keyword = "  ",
	Snippet = "  ",
	Color = "  ",
	File = "  ",
	Reference = "  ",
	Folder = "  ",
	EnumMember = "  ",
	Constant = "  ",
	Struct = "  ",
	Event = " ",
	Operator = "  ",
	TypeParameter = " ",
}

-- M.formatting = {
-- 	fields = { "kind", "abbr", "menu" },
-- 	format = function(_, vim_item)
-- 		vim_item.kind = icons[vim_item.kind] or ""
-- 		return vim_item
-- 	end,
-- }

M.formatting = {
	fields = { "kind", "abbr", "menu" },
	format = function(entry, vim_item)
		local source = entry.source.name
		local kind = vim_item.kind

		vim_item.kind = (icons[kind] or "?") .. " "
		vim_item.menu = " (" .. kind .. ")"

		if source == "nvim_lsp" then
			vim_item.dup = 0
		end

		-- tailwind code
		-- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim code coming
		-- from here, copy the code and slightly modife some settings to be able to
		-- use icons and colors.
		if vim.tbl_contains({ "nvim_lsp" }, entry.source.name) then
			local words = {}
			for word in string.gmatch(vim_item.word, "[^-]+") do
				table.insert(words, word)
			end

			if #words < 3 or #words > 4 then
				return vim_item
			end

			local color_name, color_number
			if
				words[2] == "x"
				or words[2] == "y"
				or words[2] == "t"
				or words[2] == "b"
				or words[2] == "l"
				or words[2] == "r"
			then
				color_name = words[3]
				color_number = words[4]
			else
				color_name = words[2]
				color_number = words[3]
			end

			if not color_name or not color_number then
				return vim_item
			end

			local color_index = tonumber(color_number)
			local tailwindcss_colors = require("me.cmp.tailwind_colors").TailwindcssColors

			if not tailwindcss_colors[color_name] then
				return vim_item
			end

			if not tailwindcss_colors[color_name][color_index] then
				return vim_item
			end

			local color = tailwindcss_colors[color_name][color_index]

			local hl_group = "lsp_documentColor_mf_" .. color
			vim.api.nvim_set_hl(0, hl_group, { fg = "#" .. color, bg = "#" .. color })

			vim_item.kind_hl_group = hl_group

			-- make the color square 2 chars wide
			vim_item.kind = string.rep("X", config.color_square_width)

			return vim_item
		end

		return vim_item
	end,
}

return M
