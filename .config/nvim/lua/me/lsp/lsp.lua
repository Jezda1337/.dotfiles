local status, lsp = pcall(require, "lspconfig")
if not status then
	return
end

require("me.lsp.diagnostics")
-- require("me.lsp.goto_definition") -- go to def in a split buffer

local on_attach = require("me.lsp.on_attach").on_attach
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
capabilities.textDocument.completion.completionItem.snippetSupport = true

local prettier = {
	formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:tab_width}]],
	formatStdin = true,
}

local util = require("lspconfig.util")
local function get_typescript_server_path(root_dir)
	local global_ts = "/home/[yourusernamehere]/.npm/lib/node_modules/typescript/lib"
	-- Alternative location if installed as root:
	-- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
	local found_ts = ""
	local function check_dir(path)
		found_ts = util.path.join(path, "node_modules", "typescript", "lib")
		if util.path.exists(found_ts) then
			return path
		end
	end

	if util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

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

lsp.volar.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
	init_options = {
		typescript = {
			tsdk = "/path/to/.npm/lib/node_modules/typescript/lib",
			-- Alternative location if installed as root:
			-- tsdk = '/usr/local/lib/node_modules/typescript/lib'
		},
	},
	on_new_config = function(new_config, new_root_dir)
		new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
	end,
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
