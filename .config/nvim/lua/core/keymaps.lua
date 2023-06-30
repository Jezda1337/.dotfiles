local function map(mode, lhs, rhs, desc)
	local opts = { noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, opts, desc)
end

vim.g.mapleader = " "

-- Close buffer --
map("n", "<leader>q", ":bd<CR>")

-- adding new line using = nad _ withot getting in insert mode
map("n", "=", "mzO<Esc>`z", { desc = "add blank line above" })
map("n", "_", "mzo<Esc>`z", { desc = "add blank line below" })

-- buffer jump
map("n", "]b", ":lua vim.cmd('bn')<CR>")
map("n", "[b", ":lua vim.cmd('bp')<CR>")

-- Toggle file tree
map("n", "<leader>e", ":NvimTreeToggle<CR>")
map("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")

-- Telescope --
map("n", "<leader>ff", ":Telescope find_files <CR>")
map("n", "<leader>b", ":Telescope buffers<CR>")
map("n", "<leader>fb", ":Telescope file_browser <CR>")
map("n", "<leader>fa", ":Telescope live_grep <CR>")

-- move block of code up/down --
-- map("v", "J", ":m '>+1<CR>gv=gv")
-- map("v", "K", ":m '<-2<CR>gv=gv")

-- random from reddit the same as above but with small modifications
vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })
vim.keymap.set(
	"n",
	";",
	"<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>",
	{ desc = "resume last search" }
)

map("n", "<BS>", "ci", {})

-- almost the same as multiple cursos
map("n", "<leader>w", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Split buffer --
map("n", "<C-s>", ":split<Return><C-w>w")
map("n", "<C-v>", ":vsplit<Return><C-w>w")

-- Resizing buffers --
map("n", "<S-h>", "<C-w><2")
map("n", "<S-l>", "<C-w>>2")
map("n", "<S-j>", "<C-w>+")
map("n", "<S-k>", "<C-w>-")

map("n", 'c"w', 'cw""<ESC>P')
map("n", "c'w", "cw''<ESC>P")
map("v", "'", "c''<ESC>P")
map("v", '"', 'c""<ESC>P')

-- Select buffer --
map("n", "<leader>k", "<c-w>k")
map("n", "<leader>j", "<c-w>j")
map("n", "<leader>l", "<c-w>l")
map("n", "<leader>h", "<c-w>h")
