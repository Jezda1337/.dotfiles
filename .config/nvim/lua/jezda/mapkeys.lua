local function map(mode, lhs, rhs)
	local opts = { noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "

map("n", "<leader>e", ":NvimTreeToggle<CR>")

-- keymaps for quick replace block/line of code
map({ "n", "x" }, "<leader>sr", function()
	require("ssr").open()
end)

--close buffer
map("n", "<leader>q", ":bd<CR>")

map("n", "ff", ":Telescope find_files <CR>")
map("n", "fb", ":Telescope file_browser<cr>")
map("n", "flg", ":Telescope live_grep<CR>")

--move block of code up/down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- select all
map("n", "<C-a>", "gg<S-v>G")

-- split buffer
map("n", "<C-s>", ":split<Return><C-w>w")
map("n", "<C-v>", ":vsplit<Return><C-w>w")

-- resizing buffers
map("n", "<S-h>", "<C-w><2")
map("n", "<S-l>", "<C-w>>2")
map("n", "<S-j>", "<C-w>+")
map("n", "<S-k>", "<C-w>-")

map("n", 'c"w', 'cw""<ESC>P')
map("n", "c'w", "cw''<ESC>P")
map("v", "'", "c''<ESC>P")
map("v", '"', 'c""<ESC>P')

-- select buffer
map("n", "<leader>k", "<c-w>k")
map("n", "<leader>j", "<c-w>j")
map("n", "<leader>l", "<c-w>l")
map("n", "<leader>h", "<c-w>h")

map("n", "<leader>1", ":BufferGoto 1<CR>")
map("n", "<leader>2", ":BufferGoto 2<CR>")
map("n", "<leader>3", ":BufferGoto 3<CR>")
map("n", "<leader>4", ":BufferGoto 4<CR>")
map("n", "<leader>5", ":BufferGoto 5<CR>")
map("n", "<leader>6", ":BufferGoto 6<CR>")
map("n", "<leader>7", ":BufferGoto 7<CR>")
map("n", "<leader>8", ":BufferGoto 8<CR>")
map("n", "<leader>9", ":BufferGoto 9<CR>")
