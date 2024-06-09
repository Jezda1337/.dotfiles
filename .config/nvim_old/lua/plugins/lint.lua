return {
  "mfussenegger/nvim-lint",
  events = { "BufWritePost", "BufReadPost", "InsertLeave" },
  config = function()
    require("lint").linters_by_ft = {
      markdown = { "eslint" },
      vue = { "eslint" },
      javascript = { "eslint" },
      typescript = { "eslint" },
      typescriptreact = { "eslint" },
    }
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      callback = function()
        -- require("lint").try_lint()
      end,
    })
  end,
}
