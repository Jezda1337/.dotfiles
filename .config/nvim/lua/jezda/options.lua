local options = {
	-- guicursor = "",
	syntax = "enable",
	cursorline = true,
	number = true,
	relativenumber = true,
	hidden = true,
	mouse = "a",
	virtualedit = "all",

	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,
	expandtab = true,
	smartindent = true,
	autoindent = true,

	wrap = true,
	list = false,
	linebreak = true,
	breakindent = true,

	swapfile = false,
	backup = false,
	hlsearch = false,
	incsearch = true,
	termguicolors = true,
	scrolloff = 999,
	signcolumn = "yes",
	cmdheight = 1,
	winblend = 0,
	wildoptions = "pum",
	pumblend = 5,
	background = "dark",
	shell = "zsh",
	-- clipboard = "unnamedplus",

	encoding = "utf-8",
	fileencoding = "utf-8",

	completeopt = { "menu", "menuone", "noselect" },
}

vim.opt.clipboard:append({ "unnamedplus" })
vim.scriptencoding = "utf-8"

for option, value in pairs(options) do
	vim.opt[option] = value
end
