local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
	return
end

nvim_tree.setup({
	respect_buf_cwd = true,
	view = {
		side = "right",
	},
})
