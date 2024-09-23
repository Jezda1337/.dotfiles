local options = {
	softtabstop = 2,
	tabstop = 2,
	shiftwidth = 2,
	showmode = false,
	breakindent = true,
	undofile = true,
	ignorecase = true,
	smartcase = true,
	termguicolors = true,
	number = true,
	relativenumber = true,
	backup = false,
	background = "dark",
	hidden = true, -- enable background buffers
	hlsearch = true,
	incsearch = true, -- show the match while typing
	joinspaces = false, -- no double space with join
	list = true,
	listchars = { tab = "  ", trail = "·", nbsp = "⍽", eol = "↴" },
	fillchars = { eob = " " }, -- remove ~
	scrolloff = 4,
	sidescrolloff = 4,
	signcolumn = "yes",
	splitbelow = true,
	splitright = true,
	inccommand = "split",
	cursorline = true,
	title = true,
	updatetime = 250,
	timeoutlen = 300,
	mouse = "a",
	laststatus = 3,
	cmdheight = 0,
	clipboard = "unnamedplus",
	wrap = false,
	autoread = true,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

--if vim.loop.os_uname().sysname == "Darwin" then
--  vim.g.clipboard = {
--    name = "macOS-clipboard",
--    copy = {
--      ["+"] = "pbcopy",
--      ["*"] = "pbcopy",
--    },
--    paste = {
--      ["+"] = "pbpaste",
--      ["*"] = "pbpaste",
--    },
--    cache_enabled = 0,
--  }
--end
