vim.env.LAZY_STDPATH = ".repro"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

-- require "plugins.extra.lazyGlobals"

require("lazy.minit").repro({
  spec = {
    -- add any other plugins here

    -- CMP
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
        'hrsh7th/cmp-nvim-lsp',
      },
      config = function ()
        local cmp = require('cmp')
        cmp.setup({
          snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            end,
          },
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
            { name = "buffer" },
            { name = "html-css" }
          })
        })
      end
    },

    -- LSP
    {
      {
        "williamboman/mason.nvim",
        opts = {},
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function ()
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
        config = function ()

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
      config = function ()
        require'nvim-treesitter.configs'.setup {
          ensure_installed = {"html", "css"},

        }
      end,
    },

    -- html-css
    {
   	dir = vim.env.HOME .. "/personal/nvim-html-css",
      dependencies = { "hrsh7th/nvim-cmp", "nvim-treesitter/nvim-treesitter" }, -- Use this if you're using nvim-cmp
      opts = {
        enable_on = { -- Example file types
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
        },
        documentation = {
          auto_show = true,
        },
        style_sheets = {
          "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
          "https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
          --"./index.css", -- `./` refers to the current working directory.
        },
      },
    }

  },
})
