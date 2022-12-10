local status, lsp = pcall(require, "lspconfig")
if not status then
	return
end

require("jezda.lsp.diagnostics")
require("jezda.lsp.goto_definition")
local on_attach = require("jezda.lsp.on_attach").on_attach
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
capabilities.textDocument.completion.completionItem.snippetSupport = true

local prettier = {
	formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:tab_width}]],
	formatStdin = true,
}

-- Servers --
lsp.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
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
})

lsp.emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
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
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.html.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.tailwindcss.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.tsserver.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.astro.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.bashls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.dockerls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.eslint.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.jsonls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.marksman.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.prismals.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.svelte.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.vuels.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp.yamlls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
