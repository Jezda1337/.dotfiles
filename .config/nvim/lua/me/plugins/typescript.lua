local on_attach = require("me.lsp.on_attach").on_attach
local capabilities = require("me.cmp.capabilities").capabilities

local prettier = {
	formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:tab_width}]],
	formatStdin = true,
}

require("typescript").setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
	server = { -- pass options to lspconfig's setup method
		on_attach = on_attach,
		capabilities = capabilities,
		root_dir = function()
			return vim.loop.cwd()
		end,
		init_options = { documentFormatting = true },
		settings = {
			languages = {
				typescript = { prettier },
				yaml = { prettier },
			},
		},
	},
})
