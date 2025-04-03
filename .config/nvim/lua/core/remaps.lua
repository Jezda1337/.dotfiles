local map = function(mode, lhs, rhs, opts)
	opts = opts or { noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- Open diagnostic quickfix list
map("n", "<leader>q", vim.diagnostic.setqflist)

map("n", "<C-/>", function()
    local pattern = vim.fn.input("grep: ")
    if pattern ~= "" then
        vim.cmd("silent grep! " .. pattern)
        vim.cmd("copen")
    end
end)

map("n", "<C-p>", ":find ", { noremap = true, silent = false})

map("n", "<leader>D", vim.lsp.buf.type_definition)
map("n", "gd", vim.lsp.buf.definition)
map("n", "gD", ":vsplit | lua vim.lsp.buf.definition()<CR>")

map("n", "<leader>sw", ":grep <cWORD> . | copen <CR>")

-- compile C code and run it. Doesn't work with user input (scanf)
map("n", "<leader>r", ":!gcc % -o %:p:t:r && ./%:p:t:r <CR>")

-- copy file path
map("n", "<leader>fp", ":lua  vim.fn.setreg('+', vim.fn.expand('%:.'))<CR>")
-- copy dir path
map("n", "<leader>dp", ":lua  vim.fn.setreg('+', vim.fn.expand('%:h'))<CR>")
-- copy file name
map("n", "<leader>fn", ":lua  vim.fn.setreg('+', vim.fn.expand('%:t:r'))<CR>")

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
map("n", "<C-K>", ":m -2<CR>")
map("n", "<C-J>", ":m +1<CR>")

-- duplicate line with persisten couror position
-- new way
map("n", "<A-d>", ":t.<CR>")
map("n", "<A-D>", ":t.-1<CR>")
-- old way
-- map("n", "<A-d>", "mDyyp`Dj")
-- map("i", "<A-d>", "<esc>mDyyp`Dja")

-- map("n", "<C-j>", "<C-w>j")
-- map("n", "<C-k>", "<C-w>k")
-- map("n", "<C-l>", "<C-w>l")
-- map("n", "<C-h>", "<C-w>h")

map("n", "<S-ScrollWheelUp>", "20zh")
map("n", "<S-ScrollWheelDown>", "20zl")
