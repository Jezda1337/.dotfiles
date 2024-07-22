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

					---Enable new native completions
					-- vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })

					-- if client.supports_method("textDocument/definition") then
					-- 	local lsp = vim.lsp
					-- 	local util = vim.lsp.util
					--
					-- 	-- Function to find linked CSS files in HTML
					-- 	local function find_css_files(bufnr)
					-- 		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
					-- 		local css_files = {}
					--
					-- 		for _, line in ipairs(lines) do
					-- 			for css_file in string.gmatch(line, 'href="([^"]*%.css)"') do
					-- 				table.insert(css_files, css_file)
					-- 			end
					-- 		end
					--
					-- 		return css_files
					-- 	end
					--
					-- 	-- Function to search CSS files for class or ID definitions
					-- 	local function search_css_files(css_files, word)
					-- 		for _, css_file in ipairs(css_files) do
					-- 			local css_bufnr = vim.fn.bufnr(css_file, true)
					-- 			if css_bufnr ~= -1 then
					-- 				vim.cmd("edit " .. css_file) -- Ensure the file is loaded
					-- 				local lines = vim.api.nvim_buf_get_lines(css_bufnr, 0, -1, false)
					-- 				for lnum, line in ipairs(lines) do
					-- 					if line:find("%.%s*" .. word) or line:find("#%s*" .. word) then
					-- 						return css_file, lnum -- Return file and line number
					-- 					end
					-- 				end
					-- 			end
					-- 		end
					-- 		return nil, nil
					-- 	end
					--
					-- 	-- Custom handler for 'textDocument/definition'
					-- 	local function custom_goto_definition(err, result, ctx, config)
					-- 		if err then
					-- 			vim.notify("Error: " .. err.message, vim.log.levels.ERROR)
					-- 			return
					-- 		end
					--
					-- 		local bufnr = ctx.bufnr
					-- 		local word = vim.fn.expand("<cword>")
					--
					-- 		if vim.bo.filetype == "html" then
					-- 			local css_files = find_css_files(bufnr)
					-- 			if css_files then
					-- 				local css_file, lnum = search_css_files(css_files, word)
					-- 				if css_file and lnum then
					-- 					vim.cmd("edit " .. css_file)
					-- 					vim.api.nvim_win_set_cursor(0, { lnum + 1, 0 })
					-- 					return
					-- 				end
					-- 			end
					-- 		end
					--
					-- 		-- Fallback to default LSP handling
					-- 		if not result or vim.tbl_isempty(result) then
					-- 			vim.notify("No definition found", vim.log.levels.WARN)
					-- 			return
					-- 		end
					--
					-- 		if vim.tbl_islist(result) and #result > 1 then
					-- 			vim.fn.setqflist({}, " ", {
					-- 				title = "LSP Definitions",
					-- 				items = util.locations_to_items(result),
					-- 			})
					-- 			vim.api.nvim_command("copen")
					-- 		else
					-- 			util.jump_to_location(result[1] or result)
					-- 		end
					-- 	end
					--
					-- 	-- Override the default 'textDocument/definition' handler
					-- 	vim.lsp.handlers["textDocument/definition"] = custom_goto_definition
					-- 	vim.api.nvim_set_keymap(
					-- 		"n",
					-- 		"gd",
					-- 		"<cmd>lua vim.lsp.buf.definition()<CR>",
					-- 		{ noremap = true, silent = true }
					-- 	)
					-- end
					map("g=", vim.lsp.buf.format, "Format file")
				end,
			})

			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local capabilities = nil
			capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

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
							-- capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
							capabilities = capabilities,
						})
					end,
				},
			})
		end,
	},
	{ "j-hui/fidget.nvim", opts = {} },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
}
