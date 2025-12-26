return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local if_file_exist = require("config.if_file_exist")
        local lint = require("lint")

        local local_eslint = vim.fn.getcwd() .. "/node_modules/.bin/eslint"
        if vim.fn.executable(local_eslint) == 1 then
            lint.linters.eslint.cmd = local_eslint
        end

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
                    local ok, err = pcall(lint.try_lint)
                    if not ok then
                        vim.notify("Lint failed: " .. err, vim.log.levels.WARN)
                    end
                end,
            })
        end
    end,
}
