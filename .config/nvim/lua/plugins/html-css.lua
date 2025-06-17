-- return {}
-- return {
--     "Jezda1337/nvim-html-css",
--     -- dependencies = { "hrsh7th/nvim-cmp", "nvim-treesitter/nvim-treesitter" },
--     dependencies = { "saghen/blink.cmp", "nvim-treesitter/nvim-treesitter" },
--     opts = {
--         enable_on = {
--             "txt",
--             "html",
--             "htmldjango",
--             "tsx",
--             "jsx",
--             "erb",
--             "svelte",
--             "vue",
--             "blade",
--             "php",
--             "templ",
--             "astro",
--             "typescriptreact",
--             "javascriptreact",
--             "tmpl"
--         },
--         -- notify = true,
--         documentation = {
--             auto_show = true,
--         },
--         style_sheets = {
--             "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
--             "https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
--         },
--     },
-- }
return {
    dir = vim.env.HOME .. "/personal/nvim-html-css",
    -- dependencies = { "hrsh7th/nvim-cmp", "nvim-treesitter/nvim-treesitter" },
    -- dependencies = { "saghen/blink.cmp", "nvim-treesitter/nvim-treesitter" },
    opts = {
        enable_on = {
            "txt",
            "html",
            "htmldjango",
            "tsx",
            "jsx",
            "erb",
            "svelte",
            "vue",
            "blade",
            "php",
            "templ",
            "astro",
            "tmpl",
            "typescriptreact",
            "javascriptreact",
        },
        notify = true,
        lsp = {
            enable = true,
        },
        documentation = {
            auto_show = true,
        },
        style_sheets = {
            -- "./index.css"
            -- "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
            -- "https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
        },
    },
    config = function(_, opts)
        require "html-css".setup(opts)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = opts.enable_on,
            callback = function()
                vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
            end
        })
    end
}
