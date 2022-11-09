local status, highlight_colors = pcall(require, "nvim-highlight-colors")
if not status then
	return
end

highlight_colors.setup({
	render = "foreground", -- or 'background' or 'first_column'
	enable_tailwind = true,
})
