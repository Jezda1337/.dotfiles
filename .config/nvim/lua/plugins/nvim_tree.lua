return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "MunifTanjim/nui.nvim" },
	tag = "nightly",
	config = function()
		require("nvim-tree").setup({
			respect_buf_cwd = true,
			disable_netrw = false,
			view = {
				width = 45,
				side = "right",
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
