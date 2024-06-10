return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":Mason",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					if client.supports_method("textDocument/implementation") then
						map("gi", vim.lsp.buf.implementation, "Go to Implementation")
					end

					map("g=", vim.lsp.buf.format, "Format file")
				end,
			})

			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = require("config.servers").servers
			local formatters = require("config.servers").formatters

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, formatters)

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}

						-- if server_name == "volar" then
						--   require("typescript-tools").setup(server)
						-- end

						require("lspconfig")[server_name].setup({
							cmd = server.cmd,
							settings = server.settings,
							filetypes = server.filetypes,
							capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
						})
					end,
				},
			})
		end,
	},
	{ "j-hui/fidget.nvim", opts = {} },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
}
