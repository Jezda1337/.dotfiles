return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "MunifTanjim/nui.nvim" },
	tag = "nightly",
	config = function()
		vim.cmd([[hi NvimTreeFolderIcon guifg=#ffc900]])
		require("nvim-tree").setup({
			respect_buf_cwd = true,
			disable_netrw = false,
			view = {
				centralize_selection = true,
				hide_root_folder = true,
				adaptive_size = true,
				side = "right",
				preserve_window_proportions = true,
				float = {
					enable = true,
					quit_on_focus_loss = false,
					open_win_config = function()
						return {
							row = 0,
							width = 30,
							border = "rounded",
							relative = "editor",
							col = vim.o.columns,
							height = vim.o.lines,
						}
					end,
				},
			},
			update_focused_file = {
				enable = true,
			},
			renderer = {
				icons = {
					glyphs = {
						default = "",
						symlink = "",
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
						},
					},
				},
				indent_markers = {
					enable = true,
				},
			},
		})
	end,
}
