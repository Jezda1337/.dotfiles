local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- require("luasnip.loaders.from_vscode").lazy_load() -- using vscode like snippets.
local sources = require("me.cmp.sources").sources -- sources
local formatting = require("me.cmp.formatting").formatting --formatting

local status, cmp = pcall(require, "cmp")
if not status then
	return
end

-- dosn't work :/
local cmp_autopairs = require("nvim-autopairs.completion.cmp") -- connect autopairs with cmp
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	formatting = formatting,
	-- formatting = {
	-- 	format = require("tailwindcss-colorizer-cmp").formatter,
	-- },

	window = {
		-- completion = {
		-- 	winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
		-- },
		completion = cmp.config.window.bordered({ border = "single" }),

		-- documentation = {
		-- 	winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
		-- },

		documentation = cmp.config.window.bordered({ border = "single" }),
	},

	mapping = {
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
				-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false) -- code for restart tab key to be used for normal use
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = sources,
	experimental = {
		ghost_text = false, -- still in bade shape :/
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			require("cmp-under-comparator").under,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
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
