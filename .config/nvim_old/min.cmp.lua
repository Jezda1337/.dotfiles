vim.env.LAZY_STDPATH = ".repro"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

-- require "plugins.extra.lazyGlobals"

require("lazy.minit").repro({
    spec = {
        {
            -- "Jezda1337/nvim-html-css",
            dir = vim.env.HOME .. "/personal/nvim-html-css",
            dependencies = { "hrsh7th/nvim-cmp", "nvim-treesitter/nvim-treesitter" }, -- Use this if you're using nvim-cmp
            opts = {
                enable_on = {                                                 -- Example file types
                    "html",
                    "blade",
		    "php",
                },
                handlers = {
                    definition = {
                        bind = "gd"
                    },
                    hover = {
                        bind = "K",
                        wrap = true,
                        border = "none",
                        position = "cursor",
                    },
                },
                documentation = {
                    auto_show = true,
                },
            },
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require('nvim-treesitter.configs').setup {
                    ensure_installed = { "html", "css", "php" },
                    highlight = {
                        enable = true,
                    },
                }
            end,
        },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
            },
            config = function()
                local cmp = require('cmp')
                cmp.setup({
                    snippet = {
                        expand = function(args)
                            vim.fn["vsnip#anonymous"](args.body)
                        end,
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    }),
                    sources = cmp.config.sources({
                        { name = 'html-css' },
                        { name = 'nvim_lsp' },
                        { name = 'buffer' },
                        { name = 'path' },
                    }),
                })
            end,
        },
        {
            "neovim/nvim-lspconfig",
            config = function()
                require('lspconfig').cssls.setup {
                    capabilities = require('cmp_nvim_lsp').default_capabilities(),
                }
                require('lspconfig').phpactor.setup {
                    capabilities = require('cmp_nvim_lsp').default_capabilities(),
                }
            end,
        }
    },
})
