-- When creating a new line with o, make sure there is a trailing comma on the
-- current line
vim.keymap.set("n", "o", function()
	local line = vim.api.nvim_get_current_line()

	local should_add_comma = string.find(line, "[^,{[]$")
	if should_add_comma then
		return "A,<cr>"
	else
		return "o"
	end
end, { buffer = true, expr = true })

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()
