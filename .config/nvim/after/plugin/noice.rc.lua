local status, noice = pcall(require, "noice")
if not status then
	return
end

noice.setup({
	cmdline = {
		format = {
			search_down = { icon = "🔍" },
		},
	},
	lsp = {
		progress = {
			enabled = false,
		},
		documentation = {
			view = false,
		},
	},
})

-- notify settings
require("notify").setup({
	background_colour = "#000000",
})
