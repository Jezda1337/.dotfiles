local M = {}

local util = require "lspconfig.util"

M.servers = {
    clangd = {},
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        ---https://github.com/neovim/nvim-lspconfig/issues/2948#issuecomment-1871455900
                        vim.env.VIMRUNTIME .. "/lua",
                        "${3rd}/busted/library",
                        "${3rd}/luv/library",
                    },
                },
                codeLens = {
                    enable = true,
                },
                hint = {
                    enable = true,
                },
            },
        },
    },
    ts_ls = {},
    gopls = {},
    astro = {},
    tailwindcss = {
        root_dir = function(fname)
            return util.root_pattern(
                    'tailwind.config.js',
                    'tailwind.config.cjs',
                    'tailwind.config.mjs',
                    'tailwind.config.ts',
                    'postcss.config.js',
                    'postcss.config.cjs',
                    'postcss.config.mjs',
                    'postcss.config.ts'
                )(fname) or vim.fs.dirname(vim.fs.find('package.json', { path = fname, upward = true })[1]) or
                vim.fs.dirname(
                    vim.fs.find('node_modules', { path = fname, upward = true })[1]
                ) or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = false })[1])
        end,
        settings = {
            tailwindCSS = {
                includeLanguages = {
                    templ = "html",
                },
            },
        },
    },
    bashls = {},
    -- htmx = { filetypes = { "html", "templ" } },
    html = {},
    cssls = {
        settings = {
            css = { validate = true },
            scss = { validate = true },
            less = { validate = true },
        },
    },
    eslint_d = {},
    emmet_language_server = {},
    jsonls = {},
    marksman = {},
}

M.formatters = {
    "prettier",
    "prettierd",
    "stylua",
    "goimports",
    "shfmt",
    "eslint",
}

return M
