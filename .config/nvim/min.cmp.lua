vim.env.LAZY_STDPATH = ".repro"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

-- require "plugins.extra.lazyGlobals"

require("lazy.minit").repro({
    spec = {
        -- add any other plugins here


        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            dependencies = {
                -- Snippet Engine & its associated nvim-cmp source
                {
                    'L3MON4D3/LuaSnip',
                    build = (function()
                        -- Build Step is needed for regex support in snippets.
                        -- This step is not supported in many windows environments.
                        -- Remove the below condition to re-enable on windows.
                        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                            return
                        end
                        return 'make install_jsregexp'
                    end)(),
                    dependencies = {
                        -- `friendly-snippets` contains a variety of premade snippets.
                        --    See the README about individual language/framework/plugin snippets:
                        --    https://github.com/rafamadriz/friendly-snippets
                        -- {
                        --   'rafamadriz/friendly-snippets',
                        --   config = function()
                        --     require('luasnip.loaders.from_vscode').lazy_load()
                        --   end,
                        -- },
                    },
                },
                'saadparwaiz1/cmp_luasnip',

                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-path',

                'luckasRanarison/tailwind-tools.nvim', -- Add tailwind colors to completion items
                'onsails/lspkind-nvim',                -- Add icons to completion items
            },
            config = function()
                -- See `:help cmp`
                local cmp = require 'cmp'
                local luasnip = require 'luasnip'
                luasnip.config.setup {}
                cmp.setup {
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end,
                    },
                    -- completion = { completeopt = 'menu,menuone,noinsert' },

                    -- For an understanding of why these mappings were
                    -- chosen, you will need to read `:help ins-completion`
                    --
                    -- No, but seriously. Please read `:help ins-completion`, it is really good!
                    -- mapping = cmp.mapping.preset.insert {
                    --     -- Select the [n]ext item
                    --     ['<C-n>'] = cmp.mapping.select_next_item(),
                    --     -- Select the [p]revious item
                    --     ['<C-p>'] = cmp.mapping.select_prev_item(),
                    --
                    --     -- Scroll the documentation window [b]ack / [f]orward
                    --     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    --     ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    --
                    --     -- Accept ([y]es) the completion.
                    --     --  This will auto-import if your LSP supports it.
                    --     --  This will expand snippets if the LSP sent a snippet.
                    --     ['<C-y>'] = cmp.mapping.confirm { select = true },
                    --
                    --     -- If you prefer more traditional completion keymaps,
                    --     -- you can uncomment the following lines
                    --     --['<CR>'] = cmp.mapping.confirm { select = true },
                    --     --['<Tab>'] = cmp.mapping.select_next_item(),
                    --     --['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    --
                    --     -- Manually trigger a completion from nvim-cmp.
                    --     --  Generally you don't need this, because nvim-cmp will display
                    --     --  completions whenever it has completion options available.
                    --     ['<C-Space>'] = cmp.mapping.complete {},
                    --
                    --     -- Think of <c-l> as moving to the right of your snippet expansion.
                    --     --  So if you have a snippet that's like:
                    --     --  function $name($args)
                    --     --    $body
                    --     --  end
                    --     --
                    --     -- <c-l> will move you to the right of each of the expansion locations.
                    --     -- <c-h> is similar, except moving you backwards.
                    --     ['<C-l>'] = cmp.mapping(function()
                    --         if luasnip.expand_or_locally_jumpable() then
                    --             luasnip.expand_or_jump()
                    --         end
                    --     end, { 'i', 's' }),
                    --     ['<C-h>'] = cmp.mapping(function()
                    --         if luasnip.locally_jumpable(-1) then
                    --             luasnip.jump(-1)
                    --         end
                    --     end, { 'i', 's' }),
                    --
                    --     -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                    --     --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                    -- },
                    sources = {
                        {
                            name = 'lazydev',
                            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                            group_index = 0,
                        },
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' },
                        { name = 'path' },
                        { name = 'html-css' },
                    },
                    formatting = {
                        format = function(entry, vim_item)
                            -- Primer formateador
                            local formatted_item = require('lspkind').cmp_format {
                                mode = 'symbol_text',
                                menu = {
                                    buffer = '[Buffer]',
                                    nvim_lsp = '[LSP]',
                                    luasnip = '[LuaSnip]',
                                    nvim_lua = '[Lua]',
                                    latex_symbols = '[Latex]',
                                    path = '[Path]',
                                    --html_css = '[HTML-CSS]',
                                },
                                before = require('tailwind-tools.cmp').lspkind_format, -- Add tailwind colors
                            } (entry, vim_item)

                            -- Segundo formateador
                            if entry.source.name == 'html-css' then
                                vim_item.menu = '[' .. (entry.completion_item.provider or 'html-css') .. ']'
                            end

                            return formatted_item
                        end,
                    },
                }
            end,
        },

        -- CMP
        -- {
        --   'hrsh7th/nvim-cmp',
        --   event = "InsertEnter",
        --   dependencies = {
        --     'hrsh7th/cmp-buffer',
        --     'hrsh7th/cmp-vsnip',
        --     'hrsh7th/vim-vsnip',
        --     'hrsh7th/cmp-nvim-lsp',
        --   },
        --   config = function ()
        --     local cmp = require('cmp')
        --     cmp.setup({
        --       snippet = {
        --         -- REQUIRED - you must specify a snippet engine
        --         expand = function(args)
        --           vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        --         end,
        --       },
        --       sources = cmp.config.sources({
        --         { name = 'nvim_lsp' },
        --         { name = 'vsnip' },
        --         { name = "buffer" },
        --         { name = "html-css" }
        --       })
        --     })
        --   end
        -- },

        -- LSP
        {
            {
                "williamboman/mason.nvim",
                opts = {},
            },
            {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                    require("mason-lspconfig").setup {
                        ensure_installed = { "cssls", "css_variables", "html" },
                    }
                end
            },
            {
                "neovim/nvim-lspconfig",
                dependencies = {
                    "williamboman/mason-lspconfig.nvim",
                },
                config = function()
                    local lspconfig = require("lspconfig")

                    -- List of LSP servers
                    local servers = { "cssls", "css_variables", "html" }

                    -- Mapping of LSP names to their actual executable commands
                    local server_executables = {
                        cssls = "vscode-css-language-server",
                        html = "vscode-html-language-server",
                        css_variables = "css-variables-language-server",
                    }

                    -- Function to check if an LSP executable exists
                    local function is_executable(server)
                        local cmd = server_executables[server] or server
                        return vim.fn.executable(cmd) == 1
                    end

                    local capabilities = require('cmp_nvim_lsp').default_capabilities()
                    capabilities.textDocument.completion.completionItem.snippetSupport = true
                    -- capabilities.offsetEncoding = { "utf-16" }

                    -- Setup LSPs only if installed
                    for _, server in ipairs(servers) do
                        if is_executable(server) then
                            lspconfig[server].setup({
                                capabilities = capabilities
                            })
                        else
                            vim.notify(server .. " LSP is not installed", vim.log.levels.WARN)
                        end
                    end
                end
            },
        },

        -- treesitter.lua
        {
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require 'nvim-treesitter.configs'.setup {
                    ensure_installed = { "html", "css" },

                }
            end,
        },

        {
            'Jezda1337/nvim-html-css',
            dependencies = {
                'hrsh7th/nvim-cmp',
                'nvim-treesitter/nvim-treesitter',
            },
            opts = {
                enable_on = {
                    'html',
                    'htmldjango',
                    'tsx',
                    'jsx',
                    'erb',
                    'svelte',
                    'vue',
                    'blade',
                    'php',
                    'templ',
                    'astro',
                },
                handlers = {
                    definition = {
                        bind = 'gd',
                    },
                    hover = {
                        bind = 'K',
                        wrap = true,
                        border = 'none',
                        position = 'cursor',
                    },
                },
                documentation = {
                    auto_show = true,
                },
                style_sheets = {
                     "https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
		},
            },
        },

        -- html-css
        -- {
        --     dir = vim.env.HOME .. "/personal/nvim-html-css",
        --     dependencies = { "hrsh7th/nvim-cmp", "nvim-treesitter/nvim-treesitter" }, -- Use this if you're using nvim-cmp
        --     opts = {
        --         enable_on = {                                                   -- Example file types
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
        --         },
        --         documentation = {
        --             auto_show = true,
        --         },
        --         style_sheets = {
        --             "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
        --             "https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
        --             --"./index.css", -- `./` refers to the current working directory.
        --         },
        --     },
        -- }

    },
})
