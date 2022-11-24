local status, cmp = pcall(require, "cmp")
if not status then
	return
end

require("luasnip.loaders.from_vscode").lazy_load() -- using vscode like snippets.

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup.filetype({ "lips" }, {
	sources = {
		name = "vlime",
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- local cmp_kinds = require("jezda.utils.icons").icons -- custom icons
local compare = require("cmp.config.compare")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local source_mapping = {
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	luasnip = "[Snippet]",
	buffer = "[Buffer]",
	path = "[Path]",
	-- vlime = "[Vlime]",
}

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
cmp.setup({
	completion = {
		completeopt = "menu,noselect",
	},
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
			if not luasnip then
				return
			end
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		-- format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
		-- format = function(_, vim_item)
		--   vim_item.kind = cmp_kinds.kind_icons[vim_item.kind] or ""
		--   return vim_item
		-- end,
		format = function(entry, vim_item)
			-- if you have lspkind installed, you can use it like
			-- in the following line:
			vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
			vim_item.menu = source_mapping[entry.source.name]
			if entry.source.name == "cmp_tabnine" then
				local detail = (entry.completion_item.data or {}).detail
				vim_item.kind = ""
				if detail and detail:find(".*%%.*") then
					vim_item.kind = vim_item.kind .. " " .. detail
				end

				if (entry.completion_item.data or {}).multiline then
					vim_item.kind = vim_item.kind .. " " .. "[ML]"
				end
			end
			local maxwidth = 80
			vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
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
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
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
		{ name = "cmp_tabnine", max_item_count = 10, keyword_length = 3 },
		{ name = "nvim_lsp", max_item_count = 10 },
		{ name = "nvim_lua", max_item_count = 10 },
		{ name = "luasnip", max_item_count = 5, keyword_length = 2 },
		{ name = "nvim_lsp_signature_help" },
		{ name = "buffer", keyword_length = 2 },
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

--  see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
vim.cmd([[
  highlight! link CmpItemMenu Comment
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])
