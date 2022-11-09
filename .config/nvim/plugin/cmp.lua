local status, cmp = pcall(require, "cmp")
if not status then
	return
end

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_kinds = require("jezda.utils.icons").icons -- custom icons
local luasnip = require("luasnip")
local compare = require("cmp.config.compare")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
cmp.setup({
	view = {
		entries = "custom",
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		documentation = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
		},
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		-- format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
		format = function(_, vim_item)
			vim_item.kind = cmp_kinds.kind_icons[vim_item.kind] or ""
			return vim_item
		end,
	},
	mapping = {
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			require("cmp_tabnine.compare"),
			compare.offset,
			compare.exact,
			compare.score,
			compare.recently_used,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		},
	},
	sources = {
		{ name = "cmp_tabnine" },
		{ name = "nvim_lsp", max_item_count = 30 },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "buffer" },
	},
	experimental = {
		ghost_text = true, -- still in bade shape :/
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
