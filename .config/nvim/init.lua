require("jezda.options")
require("jezda.plugins")
require("jezda.mapkeys")

-- LSP colors (error, warn, info && hint)
vim.cmd("hi DiagnosticError ctermbg=NONE ctermfg=NONE guibg=NONE guifg=#F24B42")
vim.cmd("hi DiagnosticWarn ctermbg=NONE ctermfg=NONE guibg=NONE guifg=#F5B439")
vim.cmd("hi DiagnosticInfo ctermbg=NONE ctermfg=NONE guibg=NONE guifg=#AEFA47")
vim.cmd("hi DiagnosticHint ctermbg=NONE ctermfg=NONE guibg=NONE guifg=#14BC85")
