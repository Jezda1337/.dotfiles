return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	run = ":TSUpdate",

	config = function()
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "lua", "javascript", "html", "css", "scss", "prisma", "astro", "tsx", "typescript", "vim", "json", "dockerfile", "markdown_inline" },

	autotag = { enable = true },
	highlight = { enable = true },
	indent = { enable = true },
	auto_install = true,
	context_commentstring = {
		elable = true,
		enable_autocmd = false,
	},
}
	end

}
