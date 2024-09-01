return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		{ ft = "lua", dir = vim.env.HOME .. "/personal/nvim-html-css/" },
	},
	config = function()
		local WIDE_HEIGHT = 40
		local cmp = require("cmp")

		cmp.setup({
			enabled = true,
			snippet = {
				expand = function(args)
					-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
				end,
			},

			completion = {
				autocomplete = false,
			},

			window = {
				completion = {
					border = { "", "", "", "", "", "", "", "" },
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
					winblend = vim.o.pumblend,
					scrolloff = 0,
					col_offset = 0,
					side_padding = 1,
					scrollbar = true,
				},
				documentation = {
					max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
					max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
					border = { "", "", "", " ", "", "", "", " " },
					winhighlight = "FloatBorder:NormalFloat",
					winblend = vim.o.pumblend,
				},
			},
			-- window = {
			-- 	completion = cmp.config.window.bordered(),
			-- 	documentation = cmp.config.window.bordered(),
			-- },
			view = {
				entries = {
					follow_cursor = true,
				},
			},

			experimental = {
				ghost_text = {
					enable = true,
					-- hl_group = "CmpGhostText",
				},
			},

			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			formatting = require("config.cmp"),
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
				},
				-- { name = "luasnip" },
				{
					name = "html-css",
					option = {
						enable_on = { "html" },
						spa = {
							enable = true,
							entry_file = "index.html",
						},
						-- enable_notify = true,
						-- file_extensions = { "css", "sass", "less" }, -- set the local filetypes from which you want to derive classes
						style_sheets = {
							-- example of remote styles, only css no js for now
							"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
							"https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css",
						},
					},
				},
			}, {
				name = "path",
			}),
		})
	end,
}
