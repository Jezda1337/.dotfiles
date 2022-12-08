local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	ensure_installed = {
		"lua",
		"javascript",
		"html",
		"css",
		"scss",
		"svelte",
		"prisma",
		"python",
		"go",
		"astro",
		"bash",
		"tsx",
		"typescript",
		"vim",
		"gomod",
		"json",
		"vue",
		"yaml",
		"dockerfile",
		"rust",
		"markdown",
	},
	autotag = { enable = true },
	highlight = { enable = true },
	indent = { enable = true },
	auto_install = true,
	context_commentstring = {
		elable = true,
		enable_autocmd = false,
	},
})
