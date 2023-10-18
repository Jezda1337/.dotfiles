local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local source_mapping = {
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  buffer = "[Buffer]",
  path = "[Path]",
  luasnip = "[Snip]",
}

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    { "L3MON4D3/LuaSnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-nvim-lua" },
    { "saadparwaiz1/cmp_luasnip" },
    { "lukas-reineke/cmp-under-comparator" },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    { "hrsh7th/cmp-nvim-lsp-document-symbol" },
    { "windwp/nvim-autopairs" },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local icons = require("utils.icons")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    luasnip.filetype_extend("all", { "_" })
    local compare = require("cmp.config.compare")

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },

      performance = {
        max_view_entries = 20,
      },

      preselect = cmp.PreselectMode.Item,

      window = {
        -- documentation = {
        -- 	border = "rounded",
        -- 	winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None",
        -- 	scrollbar = false,
        -- 	col_offset = 0,
        -- },
        -- completion = {
        -- 	border = "rounded",
        -- 	winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None",
        -- 	scrollbar = false,
        -- 	col_offset = 0,
        -- 	side_padding = 0,
        -- },
      },
      experimental = {
        ghost_text = true,
        native_menu = false,
      },

      -- mapping = cmp.mapping.preset.insert({
      -- 	["<C-b>"] = cmp.mapping.scroll_docs(-4),
      -- 	["<C-f>"] = cmp.mapping.scroll_docs(4),
      -- 	["<C-Space>"] = cmp.mapping.complete(),
      -- 	["<C-e>"] = cmp.mapping.abort(),
      -- 	["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      -- 	["<Tab>"] = cmp.mapping(function(fallback)
      -- 		if cmp.visible() then
      -- 			cmp.select_next_item()
      -- 			-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
      -- 			-- they way you will only jump inside the snippet region
      -- 		elseif luasnip.expand_or_jumpable() then
      -- 			luasnip.expand_or_jump()
      -- 		elseif has_words_before() then
      -- 			cmp.complete()
      -- 		else
      -- 			fallback()
      -- 		end
      -- 	end, { "i", "s" }),

      -- 	["<S-Tab>"] = cmp.mapping(function(fallback)
      -- 		if cmp.visible() then
      -- 			cmp.select_prev_item()
      -- 		elseif luasnip.jumpable(-1) then
      -- 			luasnip.jump(-1)
      -- 		else
      -- 			fallback()
      -- 		end
      -- 	end, { "i", "s" }),
      -- }),

      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-c>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.jumpable(1) then
            luasnip.jump(1)
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif check_backspace() then
            -- cmp.complete()
            fallback()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      }),

      formatting = {
        expandable_indicator = true,
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

          local source = entry.source.name
          local kind = vim_item.kind

          if source == "html-css" then
            source_mapping["html-css"] = entry.completion_item.menu
          end

          vim_item.kind = (icons[kind] or "?") .. " "
          -- vim_item.menu = " (" .. kind .. ")" -- letting lsp to decite source naming
          vim_item.menu = source_mapping[entry.source.name] -- my custom source_mapping

          -- if entry.source.name ~= "nvim_lsp" then
          -- 	vim_item.menu = source_mapping[entry.source.name] -- my custom source_mapping
          -- end
          -- vim_item.menu = " (" .. kind .. ")" -- letting lsp to decite source naming

          local strings = vim.split(vim_item.kind, "%s+", { trimempty = true })
          vim_item.kind = " " .. string.format("%s │", strings[1], strings[2]) .. " "

          if source == "nvim_lsp" then
            vim_item.dup = 1
          end

          return vim_item
        end,
      },

      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          group_index = 1,
        },
        {
          name = "luasnip",
          option = { show_autosnippets = true },
          max_view_entries = 3,
        },
        { name = "nvim_lua" },
        { name = "nvim_lsp_signature_help" },
        {
          name = "html-css",
          option = {
            max_count = {}, -- not ready yet
            enable_on = {
              "html",
            },                                           -- set the file types you want the plugin to work on
            file_extensions = { "css", "sass", "less" }, -- set the local filetypes from which you want to derive classes
            style_sheets = {
              -- example of remote styles, only css no js for now
              "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
              "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css",
            },
          },
        },
      }, {
        { name = "buffer", keyword_length = 5 },
      }),

      sorting = {
        priority_weight = 2,
        comparators = {
          compare.offset,
          compare.exact,
          compare.scopes,
          compare.score,
          compare.recently_used,
          compare.locality,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      },
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      }, {
        { name = "buffer" },
      }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    -- cmp.setup.cmdline({ "/", "?" }, {
    -- 	mapping = cmp.mapping.preset.cmdline(),
    -- 	sources = {
    -- 		{ name = "buffer" },
    -- 	},
    -- })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    -- cmp.setup.cmdline(":", {
    -- 	mapping = cmp.mapping.preset.cmdline(),
    -- 	sources = cmp.config.sources({
    -- 		{ name = "path" },
    -- 	}, {
    -- 		{ name = "cmdline" },
    -- 	}),
    -- })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer",          max_item_count = 10 },
        { name = "cmdline_history", max_item_count = 10 },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "cmdline",         max_item_count = 10 },
        { name = "cmdline_history", max_item_count = 10 },
        { name = "path",            max_item_count = 10 },
        { name = "nvim_lua",        max_item_count = 10 },
      },
    })
  end,
}
