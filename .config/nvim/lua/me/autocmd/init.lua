local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_command([[
augroup AutoCompileLatex
" autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll
augroup END
]])

vim.cmd("set rtp+=/opt/homebrew/opt/fzf")
vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- fix problem with css and ** * { ** }
