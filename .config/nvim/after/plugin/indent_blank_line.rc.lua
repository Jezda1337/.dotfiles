local status, indent_blank_line = pcall(require, "indent_blankline")
if not status then
	return
end

vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

indent_blank_line.setup({
	char = " ",
	space_char_blankline = " ",

	show_end_of_line = true,
})
