local options = {
	termguicolors = true,
	number = true,
	relativenumber = true,
	softtabstop = 2,
	tabstop = 2,
	shiftwidth = 2,
	expandtab = false, -- check :h expandtab enable this option help leadmultispace to show | guide lines
	smartindent = true, -- Insert indents automatically
	swapfile = false, -- disable swapfile (anoying thing)
	autoindent = true,
	backup = false,
	undofile = true,
	winblend = 10, -- Enables pseudo-transparency for a floating window.
	background = "dark", -- light or dark
	backspace = { "indent", "eol", "start" },
	clipboard = "unnamedplus", -- mac
	completeopt = "menu,menuone,noselect",
	cursorcolumn = false, -- disable vertical cursror highlight line
	cursorline = true, -- highlight cursorline
	encoding = "utf-8", -- set default encoding
	-- guicursor = "",           -- makes insert cursor as ablock
	guicursor = "n-v-c-sm:block-nCursor-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100-blinkwait100,r-cr-o:hor20",
	wrap = true, -- wrap lines
	breakindent = true, -- break lines are not start from begining line
	textwidth = 79,
	tw = 79,
	wrapmargin = 20,
	smoothscroll = true,
	showbreak = " ",
	hidden = true, -- Enable background buffers
	hlsearch = false, -- Highlight found searches
	ignorecase = true, -- Ignore case
	inccommand = "split", -- Get a preview of replacements
	incsearch = true, -- Shows the match while typing
	joinspaces = false, -- No double spaces with join
	linebreak = true, -- Stop words being broken on wrap
	list = false, -- Show some invisible characters
	-- listchars = {
	-- 	tab = "» ",
	-- 	trail = "·",
	-- 	eol = "↴ ",
	-- 	precedes = "←",
	-- 	extends = "→", --[[ space = "·" ]]
	-- },
	listchars = { tab = "⇥ ", leadmultispace = " │ ", trail = "␣", nbsp = "⍽" },
	fillchars = { eob = " " },
	scrolloff = 5, -- Lines of context
	shiftround = true, -- Round indent
	sidescrolloff = 8, -- Columns of context
	signcolumn = "yes", -- always show signcolumns
	smartcase = true, -- Do not ignore case with capitals
	splitbelow = true, -- Put new windows below current
	splitright = true, -- Put new windows right of current
	title = true, -- Allows neovom to send the Terminal details of the current window, instead of just getting 'v'
	updatetime = 250,
	mouse = "a", -- use mouse
	foldenable = true,
	-- foldmethod = "manual", -- manual, expr
	-- foldexpr = "nvim_treesitter#foldexpr()",
	-- formatoptions = "tcq", -- l
	-- formatoptions = "cro", -- auto comment next line after commnet
	laststatus = 3,
	cmdheight = 0,

	-- foldcolumn = "1",
	-- foldlevelstart = 99,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

-- this is special for deno_ls only, to appropriately highlight codefences returned from denols, you will need to augment vim.g.markdown_fenced languages
vim.g.markdown_fenced_languages = {
	"ts=typescript",
}

if vim.loop.os_uname().sysname == "Darwin" then
	vim.g.clipboard = {
		name = "macOS-clipboard",
		copy = {
			["+"] = "pbcopy",
			["*"] = "pbcopy",
		},
		paste = {
			["+"] = "pbpaste",
			["*"] = "pbpaste",
		},
		cache_enabled = 0,
	}
end

-- vim.opt.listchars = "tab:  "
-- vim.opt.fillchars = { eob = " ", foldopen = "", foldsep = " ", foldclose = "" }
-- vim.opt.formatoptions:remove({ "c", "r", "o" })
-- vim.opt.shortmess:append("sI")

vim.g.netrw_banner = 0 -- Disables the Netrw banner. Press 'I' to toggle.
vim.g.netrw_liststyle = 3 -- Sets the view to treeview.

-- enable H & L to move to next line, when cursor is at the line end.
vim.cmd(":set whichwrap+=<,>,h,l")

vim.g.markdown_fenced_languages =
	{ "html", "javascript", "typescript", "css", "scss", "lua", "vim" }
vim.o.whichwrap = vim.o.whichwrap .. "<,>" -- Wrap movement between lines in edit mode with arrows
