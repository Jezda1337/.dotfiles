return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			variant = "main",
		},
		config = function()
			-- vim.cmd("colorscheme rose-pine-main")
		end,
	},
	{
		"blazkowolf/gruber-darker.nvim",
		name = "best-theme-ever",
		config = function()
			vim.cmd("colorscheme gruber-darker")
		end,
	},
}
