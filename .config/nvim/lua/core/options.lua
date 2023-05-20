local options = {
	termguicolors = true,
	number = true,
	relativenumber = true,
	softtabstop = 2,
	tabstop = 2,
	shiftwidth = 2,
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
	cursorcolumn = true, -- disable vertical cursror highlight line
	cursorline = true, -- highlight cursorline
	encoding = "utf-8", -- set default encoding
	guicursor = "", -- makes insert cursor as ablock
	wrap = true, -- wrap lines
	breakindent = true, -- break lines are not start from begining line
	textwidth = 80,
	tw = 80,
	wrapmargin = 30,
	showbreak = "++",
	hidden = true, -- Enable background buffers
	hlsearch = false, -- Highlight found searches
	ignorecase = true, -- Ignore case
	inccommand = "split", -- Get a preview of replacements
	incsearch = true, -- Shows the match while typing
	joinspaces = false, -- No double spaces with join
	linebreak = true, -- Stop words being broken on wrap
	list = false, -- Show some invisible characters
	listchars = {
		tab = "» ",
		trail = "·",
		eol = "↴",
		precedes = "←",
		extends = "→", --[[ space = "·" ]]
	},
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
	foldmethod = "manual",
	formatoptions = "l",
	-- formatoptions = "cro", -- auto comment next line after commnet
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
