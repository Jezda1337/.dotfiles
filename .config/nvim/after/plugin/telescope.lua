local status, telescope = pcall(require, "telescope")
if not status then
	return
end

telescope.setup({
	defaults = {
		file_ignore_patterns = { "node_modules" },
		prompt_prefix = " ",
		selection_caret = "❯ ",
		path_display = { "truncate" },
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }, -- let me to find . || hidden files
		},
	},
})

require("telescope").load_extension("file_browser")
