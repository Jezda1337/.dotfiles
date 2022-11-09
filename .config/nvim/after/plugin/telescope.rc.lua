local status, telescope = pcall(require, "telescope")
if not status then
	return
end
local fb_actions = require("telescope").extensions.file_browser.actions
telescope.load_extension("noice")

telescope.setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git",
		},
	},

	pickers = {
		find_files = {
			theme = "dropdown",
			hidden = true,
			prompt_position = "top",
			prompt_prefix = "🔍",
		},

		extensions = {
			file_browser = {
				theme = "ivy",
				-- disables netrw and use telescope-file-browser in its place
				hijack_netrw = true,
				mappings = {
					["i"] = {},
					["n"] = {},
				},
			},
		},
		borderchars = {
			prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
			results = { " " },
			preview = { " " },
		},
	},
})
