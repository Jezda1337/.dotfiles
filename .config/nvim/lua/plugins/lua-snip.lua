return {
	"L3MON4D3/LuaSnip",
	opts = {
		history = true,
		delete_check_events = "TextChanged",
		region_check_events = "CursorMoved",
	},
	version = "1.2.1.*",
	dependencies = { { "rafamadriz/friendly-snippets" } },
	build = "make install_jsregexp",
	config = function()
		-- require("luasnip.loaders.from_vscode").lazy_load()

		local luasnip = require("luasnip")
		local unlink_group = vim.api.nvim_create_augroup("UnlinkSnippet", {})
		vim.api.nvim_create_autocmd("ModeChanged", {
			group = unlink_group,
			-- when going from select mode to normal and when leaving insert mode
			pattern = { "s:n", "i:*" },
			callback = function(event)
				if
					luasnip.session
					and luasnip.session.current_nodes[event.buf]
					and not luasnip.session.jump_active
				then
					luasnip.unlink_current()
				end
			end,
		})

		local types = require("luasnip.util.types")
		require("luasnip").setup({
			xt_opts = {
				[types.insertNode] = {
					unvisited = {
						virt_text = { { "|", "Conceal" } },
						virt_text_pos = "inline",
					},
				},
				-- This is needed because LuaSnip differentiates between $0 and other
				-- placeholders (exitNode and insertNode). So this will highlight the last
				-- jump node.
				[types.exitNode] = {
					unvisited = {
						virt_text = { { "|", "Conceal" } },
						virt_text_pos = "inline",
					},
				},
			},
		})
	end,
}
