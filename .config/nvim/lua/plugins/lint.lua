return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local if_file_exist = require("config.if_file_exist")
        local lint = require("lint")
        lint.linters_by_ft = {
            javascript = { "eslint" },
            typescript = { "eslint" },
            javascriptreact = { "eslint" },
            typescriptreact = { "eslint" },
            vue = { "eslint" },
        }

        if if_file_exist("eslint*") then
            local lint_group = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "InsertLeave" }, {
                group = lint_group,
                callback = function()
                    lint.try_lint()
                end,
            })
        end
    end,
}
