-- Install with: go install golang.org/x/tools/gopls@latest

---@type vim.lsp.Config
-- return {
--     cmd = { "gopls" },
--     root_markers = { "go.mod" },
--     filetypes = { "go", "gomod", "gowork", "gotmpl" },
--     settings = {
--         gopls = {
--             hints = {
--                 assignVariableTypes = true,
--                 compositeLiteralFields = true,
--                 compositeLiteralTypes = true,
--                 constantValues = true,
--                 functionTypeParameters = true,
--                 parameterNames = true,
--                 rangeVariableTypes = true,
--             },
--         },
--     },
-- }

---@type vim.lsp.Config
return {
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type lspconfig.settings.gopls
    settings = {
        gopls = {
            gofumpt = true,
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
                unusedparams = true,
                unusedwrite = true,
                useany = true,
            },
            usePlaceholders = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
        },
    },
}
