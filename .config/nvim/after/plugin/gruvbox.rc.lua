vim.g.gruvbox_baby_function_style = "italic"
vim.g.gruvbox_baby_keyword_style = "italic"

vim.g.gruvbox_baby_telescope_theme = 0 -- 0 means disable telescope theme

if vim.fn.has("g:neovide") == 1 then
	vim.g.gruvbox_baby_transparent_mode = 0 -- 1 means elable transparend mode
	print(vim.fn.exists("g:neovide"))
else
	vim.g.gruvbox_baby_transparent_mode = 1 -- 1 means elable transparend mode
end

vim.g.gruvbox_baby_background_color = "dark"

vim.cmd([[colorscheme gruvbox-baby]])

vim.cmd([[hi NvimTreeFolderIcon guifg=#458588]]) -- make folder color different from default
vim.cmd([[highlight cursorLineNr guifg=#FABD2F]]) -- add custom color for hoverd number
