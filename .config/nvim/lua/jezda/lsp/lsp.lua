local status, lsp = pcall(require, "lspconfig")
if not status then
	return
end

require("jezda.lsp.diagnostics")
local on_attach = require("jezda.lsp.on_attach").on_attach

local prettier = {
	formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:tab_width}]],
	formatStdin = true,
}

-- Servers --
lsp.sumneko_lua.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";", {}),
			},
			diagnostics = {
				globals = { "vim" },
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
})

lsp.tsserver.setup({
	on_attach = on_attach,
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
})

lsp.emmet_ls.setup({
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})

lsp.cssls.setup({
	on_attach = on_attach,
})

lsp.html.setup({
	on_attach = on_attach,
})

lsp.tailwindcss.setup({
	on_attach = on_attach,
})

lsp.tsserver.setup({
	on_attach = on_attach,
})

lsp.gopls.setup({
	on_attach = on_attach,
})

lsp.astro.setup({
	on_attach = on_attach,
})

lsp.bashls.setup({
	on_attach = on_attach,
})

lsp.dockerls.setup({
	on_attach = on_attach,
})

lsp.eslint.setup({
	on_attach = on_attach,
})

lsp.jsonls.setup({
	on_attach = on_attach,
})

lsp.marksman.setup({
	on_attach = on_attach,
})

lsp.prismals.setup({
	on_attach = on_attach,
})

lsp.pyright.setup({
	on_attach = on_attach,
})

lsp.svelte.setup({
	on_attach = on_attach,
})

lsp.vuels.setup({
	on_attach = on_attach,
})

lsp.yamlls.setup({
	on_attach = on_attach,
})
