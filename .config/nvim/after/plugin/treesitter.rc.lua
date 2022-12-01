local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

local status2, context = pcall(require, "treesitter-context")
if not status2 then
	return
end

context.setup({})

treesitter.setup({
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	yati = {
		enable = true,
		default_lazy = true,
		default_fallback = "auto",
	},
	autotag = {
		enable = true,
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = false,
	},
	auto_install = true,
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},

	ensure_installed = {
		"lua",
		"rust",
		"javascript",
		"bash",
		"css",
		"dockerfile",
		"gitignore",
		"gitattributes",
		"go",
		"gomod",
		"gowork",
		"html",
		"json",
		"markdown",
		"python",
		"prisma",
		"scss",
		"sql",
		"svelte",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"yaml",
	},
})
