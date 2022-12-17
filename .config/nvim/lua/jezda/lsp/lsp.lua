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

local servers = {
	"clangd",
	"cssls",
	"html",
	"tailwindcss",
	"gopls",
	"astro",
	"bashls",
	"dockerls",
	"eslint",
	"jsonls",
	"marksman",
	"prismals",
	"pyright",
	"svelte",
	"vuels",
	"yamlls",
}

for _, server in ipairs(servers) do
	require("lspconfig")[server].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

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
