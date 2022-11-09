local function map(mode, lhs, rhs)
	local opts = { noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "

map("n", "<leader>e", ":NvimTreeToggle<CR>")

map("n", "<leader>q", ":bd<CR>")

map("n", "ff", ":Telescope find_files <CR>")
map("n", "fb", ":Telescope file_browser<cr>")
map("n", "lg", ":Telescope live_grep<CR>")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-s>", ":split<Return><C-w>w")
map("n", "<C-v>", ":vsplit<Return><C-w>w")

map("n", 'c"w', 'cw""<ESC>P')
map("n", "c'w", "cw''<ESC>P")
map("v", "'", "c''<ESC>P")
map("v", '"', 'c""<ESC>P')

map("n", "<leader>k", "<c-w>k")
map("n", "<leader>j", "<c-w>j")
map("n", "<leader>l", "<c-w>l")
map("n", "<leader>h", "<c-w>h")
map("n", "<c-k>", "<c-w>k")

map("n", "<leader>1", ":BufferGoto 1<CR>")
map("n", "<leader>2", ":BufferGoto 2<CR>")
map("n", "<leader>3", ":BufferGoto 3<CR>")
map("n", "<leader>4", ":BufferGoto 4<CR>")
map("n", "<leader>5", ":BufferGoto 5<CR>")
map("n", "<leader>6", ":BufferGoto 6<CR>")
map("n", "<leader>7", ":BufferGoto 7<CR>")
map("n", "<leader>8", ":BufferGoto 8<CR>")
map("n", "<leader>9", ":BufferGoto 9<CR>")
