return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = (function()
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
    },
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    { "windwp/nvim-autopairs", opts = {} },
  },
  config = function()
    local cmp = require("cmp")
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    local luasnip = require("luasnip")
    luasnip.config.setup({})

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- snippet = {
      --   expand = vim.snippet and function(args)
      --     vim.snippet.expand(args.body)
      --   end or function(_)
      --     error("snippet engine is not configured.")
      --   end,
      -- },

      completion = { completeopt = "menu,noinsert" },

      performance = {
        max_view_entries = 10,
      },

      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },

      formatting = require("plugins.cmp.utils.formatting"),

      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        {
          name = "html-css",
          option = {
            max_count = {}, -- not ready yet
            enable_on = {
              "html",
            }, -- set the file types you want the plugin to work on
            file_extensions = { "css", "sass", "less" }, -- set the local filetypes from which you want to derive classes
            style_sheets = {
              -- example of remote styles, only css no js for now
              "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
              "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css",
            },
          },
        },
      },
    })
  end,
}
