-- Install with: go install golang.org/x/tools/gopls@latest

---@type vim.lsp.Config
return {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type lspconfig.settings.gopls
    settings = {
        gopls = {
            gofumpt = true,
            completeUnimported = true, -- Auto-suggest and auto-import packages
            usePlaceholders = true,
            staticcheck = true,
            semanticTokens = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            analyses = {
                nilness = true,
                shadow = true, -- Warn on shadowed variables
                unusedparams = true,
                unusedwrite = true,
                useany = true,
            },
        },
    },
}
