return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      build = ":Mason",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
    },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        -- local signs = {
        --   Error = " ",
        --   Warn = " ",
        --   Info = " ",
        --   Hint = " ",
        -- }

        -- for type, icon in pairs(signs) do
        --   local hl = "DiagnosticSign" .. type
        --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        -- end

        -- vim.diagnostic.config({
        --   signs = true,
        --   severity_sort = true,
        --   virtual_text = {
        --     prefix = signs.Warn,
        --     source = true,
        --   },
        -- })

        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", function()
          vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
        end, "[C]ode [A]ction")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- if vim.bo.filetype ~= "markdown" and vim.bo.filetype ~= "json" then
        --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        --     buffer = event.buf,
        --     callback = vim.lsp.buf.document_highlight,
        --   })
        --
        --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        --     buffer = event.buf,
        --     callback = vim.lsp.buf.clear_references,
        --   })
        -- end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    local servers = {
      astro = {},
      bashls = {},
      clangd = {},
      gopls = {},
      pyright = {},
      tsserver = {
        -- init_options = {
        --   hostInfo = "neovim",
        --   plugins = {
        --     {
        --       name = "@vue/typescript-plugin",
        --       location = vim.env.HOME .. "/.nvm/versions/node/v21.4.0/lib/node_modules/@vue/typescript-plugin",
        --       languages = { "vue" },
        --     },
        --   },
        -- },
        -- filetypes = {
        --   "javascript",
        --   "typescript",
        --   "vue",
        -- },
      },
      jsonls = {},
      marksman = {},
      ["rust-analyzer"] = {},
      -- volar = {
      --   init_options = {
      --     typescript = {
      --       tsdk = vim.env.HOME .. "/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib",
      --     },
      --   },
      -- },
      ["vetur-vls"] = {}, -- vue 2
      html = {},
      emmet_language_server = {},
      cssls = {
        settings = {
          css = {
            validate = true,
            lint = { unknownAtRules = "ignore" }, -- ignore @ rules like @tailwind
          },
          scss = { validate = true },
          less = { validate = true },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              -- Tells lua_ls where to find all the Lua files that you have loaded
              -- for your neovim configuration.
              library = {
                "${3rd}/luv/library",
                unpack(vim.api.nvim_get_runtime_file("", true)),
              },
              -- If lua_ls is really slow on your computer, you can try this instead:
              -- library = { vim.env.VIMRUNTIME },
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
            completion = {
              callSnippet = "Replace",
            },
            telemetry = {
              enable = false,
            },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
          },
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua",
      "prettier",
      "prettierd",
      "goimports",
      "shfmt",
      "eslint",
    })

    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}

          -- if server_name == "volar" then
          --   require("typescript-tools").setup(server)
          -- end

          require("lspconfig")[server_name].setup({
            cmd = server.cmd,
            settings = server.settings,
            filetypes = server.filetypes,
            capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
          })
        end,
      },
    })
  end,
}
