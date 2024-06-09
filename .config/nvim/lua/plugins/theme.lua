return {
	"rose-pine/neovim",
	name = "rose-pine",
	opts = {
		variant = "main",
	},
	config = function()
		vim.cmd("colorscheme rose-pine-main")
	end,
}
