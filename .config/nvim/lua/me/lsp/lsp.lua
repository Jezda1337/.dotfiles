local status, lsp = pcall(require, "lspconfig")
if not status then
	return
end

local sumneko_lua = require("me.lsp.servers_config.sumneko_lua")
local emmet_ls = require("me.lsp.servers_config.emmet_ls")
local cssls = require("me.lsp.servers_config.cssls")

local on_attach = require("me.lsp.on_attach").on_attach
require("me.lsp.diagnostics")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
	"clangd",
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
	"yamlls",
	"diagnosticls",
}

for _, server in ipairs(servers) do
	require("lspconfig")[server].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

-- Custom servers configuration --
lsp.lua_ls.setup(sumneko_lua.config)
lsp.emmet_ls.setup(emmet_ls.config)
lsp.cssls.setup(cssls.config)
