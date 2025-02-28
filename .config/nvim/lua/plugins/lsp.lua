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
		opts = { inly_hints = { enable = true } },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- if client == nil or not client:supports_method("textDocument/inlayHint", 0) then
					-- 	return
					-- end
					-- vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })

					if client:supports_method("textDocument/implementation") ~= nil then
						map("gi", vim.lsp.buf.implementation, "Go to Implementation")
					else
						print("Go to Implementation is not supported")
					end


					---Enable new native completions
					-- vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })

					map("g=", vim.lsp.buf.format, "Format file")
					map("gd", vim.lsp.buf.definition, "Go to definition")
				end,
			})

			-- local capabilities = vim.lsp.protocol.make_client_capabilities() -- this one doesn't add all autocompletion
			local capabilities = require("cmp_nvim_lsp").default_capabilities() -- this one add autocompletion for some files 

			local servers = require("config.servers").servers
			local formatters = require("config.servers").formatters

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, formatters)

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}

						require("lspconfig")[server_name].setup({
							cmd = server.cmd,
							root_dir = server.root_dir,
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
