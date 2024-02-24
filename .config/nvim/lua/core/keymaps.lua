local map = function(mode, lhs, rhs)
  local opts = { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>e", vim.diagnostic.open_float)
map("n", "<leader>q", vim.diagnostic.setloclist)

-- map("n", "<leader>q", ":bd<cr>")
map("n", "<leader>e", vim.cmd.Ex)

-- increase/decrease numbers
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- buffer jump
map("n", "]b", ":lua vim.cmd('bn')<CR>")
map("n", "[b", ":lua vim.cmd('bp')<CR>")

-- moving whole lines up or down
map("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo")
map("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo")

map("n", "<BS>", "ci")

map("n", 'c"w', 'cw""<ESC>P')
map("n", "c'w", "cw''<ESC>P")
map("n", "c[w", "cw[]<ESC>P")
map("n", "c{w", "cw{}<ESC>P")
map("n", "c<w", "cw<><ESC>P")
map("n", "c(w", "cw()<ESC>P")
map("v", "'", "c''<ESC>P")
map("v", '"', 'c""<ESC>P')
