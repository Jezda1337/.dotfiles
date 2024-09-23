local map = function(mode, lhs, rhs)
	local opts = { noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- open lazygit
map("n", "<leader>lg", ":term lazygit<cr>")

-- increase/decrease numbers
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- buffer jump
map("n", "]b", ":lua vim.cmd('bn')<CR>")
map("n", "[b", ":lua vim.cmd('bp')<CR>")

-- moving whole lines up or down
map("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo")
map("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo")

map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-h>", "<C-w>h")
