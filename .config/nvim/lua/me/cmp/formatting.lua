local M = {}

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
	format = function(_, vim_item)
		local kind = vim_item.kind

		vim_item.kind = (icons[kind] or "?") .. " "
		vim_item.menu = " (" .. kind .. ")"
		return vim_item
	end,
}

-- Tailwindcss color idicators almost like in vscode
-- local blackOrWhiteFg = function(r, g, b)
-- 	return ((r * 0.299 + g * 0.587 + b * 0.114) > 186) and "#000000" or "#ffffff"
-- end
--
-- M.formatting = {
-- 	fields = { "kind", "abbr" },
-- 	format = function(entry, vim_item)
-- 		if vim_item.kind == "Color" and entry.completion_item.documentation then
-- 			local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
-- 			if r then
-- 				local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
-- 				local group = "Tw_" .. color
-- 				if vim.fn.hlID(group) < 1 then
-- 					vim.api.nvim_set_hl(0, group, { fg = blackOrWhiteFg(r, g, b), bg = "#" .. color })
-- 				end
-- 				vim_item.kind = " " .. icons[vim_item.kind] .. " "
-- 				vim_item.kind_hl_group = group
-- 				return vim_item
-- 			end
-- 		end
-- 		-- vim_item.kind = icons[vim_item.kind] and (icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
-- 		-- or just show the icon
-- 		vim_item.kind = icons[vim_item.kind] and icons[vim_item.kind] or vim_item.kind
-- 		return vim_item
-- 	end,
-- }

return M
