local options = {
	-- guicursor = "",
	syntax = "enable",
	cursorline = true,
	number = true,
	relativenumber = true,
	hidden = true,
	mouse = "a",
	-- virtualedit = "all", -- make clicable to anywhere on the panel

	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,
	expandtab = false, -- use tabs instead of spaces
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
	fillchars = { eob = " " }, -- remove tilda from empty lines in buffer.
}

vim.opt.clipboard:append({ "unnamedplus" })
vim.scriptencoding = "utf-8"

for option, value in pairs(options) do
	vim.opt[option] = value
end
