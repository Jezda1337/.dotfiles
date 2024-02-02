-- not sure why this 1st part is needed but ok
local util = require("lspconfig.util")
local function get_typescript_server_path(root_dir)
	local project_root = util.find_node_modules_ancestor(root_dir)
	return project_root and (util.path.join(project_root, "node_modules", "typescript", "lib")) or ""
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.start({
	cmd = { "astro-ls", "--stdio" },
	filetypes = { "astro" },
	root_dir = vim.fs.dirname(
		vim.fs.find({ "package.json", "tsconfig.json", "jsconfig.json", ".git" }, { upward = true })[1]
	),
	capabilities = capabilities,
	on_attach = require("plugins.utils.on_attach").on_attach,
	init_options = {
		typescript = {},
	},
	before_init = function(_, config)
		if
			vim.tbl_get(config.init_options, "typescript") and not config.init_options.typescript.tsdk
		then
			config.init_options.typescript.tsdk = get_typescript_server_path(config.root_dir)
		end
	end,
	default_config = {
		root_dir = [[root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")]],
	},
})
