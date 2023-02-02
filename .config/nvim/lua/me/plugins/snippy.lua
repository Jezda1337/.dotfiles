local status, snippy = pcall(require, "snippy")
if not status then
	return
end

snippy.setup({
	mappings = {
		is = {
			["<Tab>"] = "expand_or_advance",
			["<S-Tab>"] = "previous",
		},
		nx = {
			["<leader>x"] = "cut_text",
		},
	},
})
