local on_attach = require("plugins.lsp.on_attach")
local config = {}

function config.neodev()
	require("neodev").setup({})
end

function config.mason()
	require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})
end

function config.mason_lsp()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"lua_ls",
			"prismals",
			"tailwindcss",
			"gopls",
			"html",
			"cssls",
			"astro",
			"emmet_ls",
			"eslint",
			"marksman",
			"volar",
			"denols",
			"angularls",
		},
	})
end

function config.lsp()
	local signs = {
		Error = " ",
		Warn = " ",
		Info = " ",
		Hint = " ",
	}

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	vim.diagnostic.config({
		signs = true,
		severity_sort = true,
		virtual_text = {
			prefix = "🔥",
			source = true,
		},
	})

	local lsp = require("lspconfig")
	-- old capabilities
	-- local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- capabilities.textDocument.completion.completionItem.snippetSupport = true -- true

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	local servers = {
		"html",
		"cssls",
		-- "emmet_ls", -- have some wierd completion
		-- "tailwindcss",
		"jsonls",
		"astro",
		"prismals",
		"dockerls",
		"eslint",
		"marksman",
		"gopls",
		-- "angularls",
	}

	for _, server in ipairs(servers) do
		lsp[server].setup({
			capabilities = capabilities,
			on_attach = on_attach.on_attach,
		})
	end
	require("plugins.lsp.servers_config.lua_ls").lua_ls(capabilities, on_attach)
	require("plugins.lsp.servers_config.vue_ls").vue_ls(capabilities, on_attach)
	-- require("plugins.lsp.servers_config.emmet_ls").emmet_ls(capabilities, on_attach)
	require("plugins.lsp.servers_config.deno_ls").deno_ls(capabilities, on_attach)
	require("plugins.lsp.servers_config.angular_ls").angular_ls(capabilities, on_attach)
	require("plugins.lsp.servers_config.tailwind_ls").tailwind_ls(capabilities, on_attach)
end

---------
-- CMP --
---------

function config.cmp()
	local cmp = require("cmp")
	local cmp_mapping = require("cmp.config.mapping")
	local cmp_types = require("cmp.types.cmp")
	local utils = require("utils.cmp")
	local luasnip = require("luasnip")

	local cmp_config = {
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		preselect = cmp.PreselectMode.Item,
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		formatting = require("plugins.lsp.formatting").formatting,
		duplicates = {
			nvim_lsp = 1,
			luasnip = 1,
			buffer = 1,
			path = 1,
		},
		experimental = {
			ghost_text = true,
		},
		-- mapping = {
		-- 	["<C-e>"] = cmp.mapping.abort(),
		-- 	["<CR>"] = cmp.mapping.confirm({
		-- 		behavior = cmp.ConfirmBehavior.Replace,
		-- 		select = false,
		-- 	}),
		-- 	["<Tab>"] = cmp.mapping(function(fallback)
		-- 		if cmp.visible() then
		-- 			cmp.select_next_item()
		-- 		elseif has_words_before() then
		-- 			cmp.complete()
		-- 		else
		-- 			fallback()
		-- 			-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false) -- code for restart tab key to be used for normal use
		-- 		end
		-- 	end, { "i", "s" }),
		-- },

		mapping = cmp_mapping.preset.insert({
			["<C-k>"] = cmp_mapping(cmp_mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = cmp_mapping(cmp_mapping.select_next_item(), { "i", "c" }),
			["<Down>"] = cmp_mapping(cmp_mapping.select_next_item({ behavior = cmp_types.SelectBehavior.Select }), {
				"i",
			}),
			["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item({ behavior = cmp_types.SelectBehavior.Select }), {
				"i",
			}),
			["<C-d>"] = cmp_mapping.scroll_docs(-4),
			["<C-f>"] = cmp_mapping.scroll_docs(4),
			["<C-y>"] = cmp_mapping({
				i = cmp_mapping.confirm({ behavior = cmp_types.ConfirmBehavior.Replace, select = false }),
				c = function(fallback)
					if cmp.visible() then
						cmp.confirm({ behavior = cmp_types.ConfirmBehavior.Replace, select = false })
					else
						fallback()
					end
				end,
			}),
			["<Tab>"] = cmp_mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				elseif utils.jumpable(1) then
					luasnip.jump(1)
				elseif utils.has_words_before() then
					-- cmp.complete()
					fallback()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp_mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-Space>"] = cmp_mapping.complete(),
			["<C-e>"] = cmp_mapping.abort(),
			["<CR>"] = cmp_mapping(function(fallback)
				if cmp.visible() then
					local confirm_opts = vim.deepcopy({
						behavior = cmp_types.ConfirmBehavior.Replace,
						select = false,
					}) -- avoid mutating the original opts below
					local is_insert_mode = function()
						return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
					end
					if is_insert_mode() then -- prevent overwriting brackets
						confirm_opts.behavior = cmp_types.ConfirmBehavior.Insert
					end
					local entry = cmp.get_selected_entry()
					local is_copilot = entry and entry.source.name == "copilot"
					if is_copilot then
						confirm_opts.behavior = cmp_types.ConfirmBehavior.Replace
						confirm_opts.select = true
					end
					if cmp.confirm(confirm_opts) then
						return -- success, exit early
					end
				end
				fallback() -- if not exited early, always fallback
			end),
		}),

		sources = cmp.config.sources(require("plugins.lsp.cmp_sources").config),
		sorting = {
			comparators = {
				require("cmp-under-comparator").under, -- better cmp sorting
				function(entry1, entry2)
					local _, entry1_under = entry1.completion_item.label:find("^_+")
					local _, entry2_under = entry2.completion_item.label:find("^_+")
					entry1_under = entry1_under or 0
					entry2_under = entry2_under or 0
					if entry1_under > entry2_under then
						return false
					elseif entry1_under < entry2_under then
						return true
					end
				end,
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
	}

	local cmp_autopairs = require("nvim-autopairs.completion.cmp") -- connect autopairs with cmp
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "nvim_lsp_document_symbol" },
		}, {
			{ name = "buffer" },
		}),
	})

	cmp.setup(cmp_config)

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

---------------------
-- LUA SNIP
---------------------

function config.lua_snip()
	local ls = require("luasnip")
	local types = require("luasnip.util.types")
	ls.config.set_config({
		history = false,
		enable_autosnippets = true,
		-- updateevents = "TextChanged,TextChangedI",
		-- ext_opts = {
		-- 	[types.choiceNode] = {
		-- 		active = {
		-- 			virt_text = { { "<- choiceNode", "Comment" } },
		-- 		},
		-- 	},
		-- 	[types.insertNode] = {
		-- 		active = {
		-- 			virt_text = { { "●", "LuasnipInsert" } },
		-- 		},
		-- 	},
		-- },
	})

	-- Snippets
	-- work but on save or any change duplicate the snippet in file
	-- require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })
	-- require("luasnip.loaders.from_vscode").lazy_load() -- global snippets
end

function config.typescript()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	local prettier = {
		formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:tab_width}]],
		formatStdin = true,
	}
	require("typescript").setup({
		disable_commands = false, -- prevent the plugin from creating Vim commands
		debug = false,          -- enable debug logging for commands
		go_to_source_definition = {
			fallback = true,      -- fall back to standard LSP definition on failure
		},
		server = {
			-- pass options to lspconfig's setup method
			on_attach = on_attach.on_attach,
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
end

function config.mason_null_ls()
	require("mason-null-ls").setup({
		ensure_installed = { "stylua", "prettier", "eslint", "shfmt", "goimports" },
		automatic_installation = true,
		automatic_setup = true,
	})
end

function config.null_ls()
	local null_ls = require("null-ls")

	local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
	local event = "BufWritePre" -- or "BufWritePost"
	local async = event == "BufWritePost"

	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	null_ls.setup({
		border = "single",
		sources = {
			-- null_ls.builtins.diagnostics.cspell,
			-- null_ls.builtins.code_actions.cspell,
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier,
			null_ls.builtins.formatting.prismaFmt,
			null_ls.builtins.completion.luasnip,
			null_ls.builtins.diagnostics.eslint.with({
				diagnostics_format = "[eslint] #{m}\n(#{c})",
				-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
				condition = function(utils)
					return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
				end,
			}),
			null_ls.builtins.formatting.gofmt,
			null_ls.builtins.formatting.goimports,
		},
		-- on_attach = function(client, bufnr)
		-- 	if client.supports_method("textDocument/formatting") then
		-- 		vim.keymap.set("n", "<Leader>f", function()
		-- 			vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
		-- 		end, { buffer = bufnr, desc = "[lsp] format" })

		-- 		-- format on save
		-- 		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
		-- 		vim.api.nvim_create_autocmd(event, {
		-- 			buffer = bufnr,
		-- 			group = group,
		-- 			callback = function()
		-- 				vim.lsp.buf.format({ bufnr = bufnr, async = async })
		-- 			end,
		-- 			desc = "[lsp] format on save",
		-- 		})
		-- 	end

		-- 	if client.supports_method("textDocument/rangeFormatting") then
		-- 		vim.keymap.set("x", "<Leader>f", function()
		-- 			vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
		-- 		end, { buffer = bufnr, desc = "[lsp] format" })
		-- 	end
		-- end,
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
						-- vim.lsp.buf.formatting_sync()
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end
		end,
	})
end

function config.prettier()
	local prettier = require("prettier")

	prettier.setup({
		bin = "prettier", -- or `'prettierd'` (v0.23.3+)
		filetypes = {
			"css",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"less",
			"markdown",
			"scss",
			"typescript",
			"typescriptreact",
			"yaml",
			"vue",
		},
	})
end

function config.lspsaga()
	require("lspsaga").setup({
		diagnostic = {
			on_insert = false,
		},
	})
end

function config.autopairs()
	local autopairs = require("nvim-autopairs")
	local Rule = require("nvim-autopairs.rule")
	local ts_conds = require("nvim-autopairs.ts-conds")

	autopairs.setup({
		check_ts = true,
		enable_moveright = true,
	})

	autopairs.add_rules({
		-- Typing { when {| -> {{ | }} in Vue files
		Rule("{", "  }", { "typescriptreact", "tsx", "javascript", "typescript" })
				:set_end_pair_length(2)
				:with_pair(ts_conds.is_ts_node("text")),

		-- Typing = when () -> () => {|}
		Rule("%(.*%)%s*%=$", "> {}", { "typescript", "typescriptreact", "javascript", "vue" })
				:use_regex(true)
				:set_end_pair_length(1),

		-- Typing n when the| -> then|end
		Rule("then", "end", "lua"):end_wise(function(opts)
			return string.match(opts.line, "^%s*if") ~= nil
		end),
	})
end

return config
