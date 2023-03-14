local on_attach = require "plugins.lsp.on_attach"
local config = {}

function config.mason()
	require("mason").setup({})
end

function config.mason_lsp()
	require("mason-lspconfig").setup({
		ensure_installed = { "lua_ls", "prismals", "tailwindcss", "html", "cssls", "astro", "emmet_ls" }
	})
end

function config.lsp()
	local signs = {
		Error = ' ',
		Warn = ' ',
		Info = ' ',
		Hint = ' ',
	}

	for type, icon in pairs(signs) do
		local hl = 'DiagnosticSign' .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	vim.diagnostic.config({
		signs = true,
		severity_sort = true,
		virtual_text = {
			prefix = '🔥',
			source = true,
		}
	})

	local lsp = require("lspconfig")
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	local servers = {
		"html",
		"cssls",
		"emmet_ls",
		"tailwindcss",
		"jsonls",
		"astro",
		"prismals",
		"dockerls",
	}

	for _, server in ipairs(servers) do
		lsp[server].setup({
			capabilities = capabilities,
			on_attach = on_attach.on_attach,
		})
	end
	require("plugins.lsp.servers_config.lua_ls").lua_ls(capabilities, on_attach)
end

---------
-- CMP --
---------

function config.cmp()
	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end
	local cmp = require("cmp")

	local cmp_config = {
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		preselect = cmp.PreselectMode.Item,
		-- window = {
		-- 	completion = cmp.config.window.bordered(),
		-- 	documentation = cmp.config.window.bordered(),
		-- },
		formatting = require("plugins.lsp.formatting").formatting,
		duplicates = {
			nvim_lsp = 1,
			luasnip = 1,
			buffer = 1,
			path = 1,
		},
		mapping = {
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
					-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false) -- code for restart tab key to be used for normal use
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }),
		},
		sources = require("plugins.lsp.sources"),
		sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				require("cmp-under-comparator").under, -- better cmp sorting
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
	}

	local cmp_autopairs = require("nvim-autopairs.completion.cmp") -- connect autopairs with cmp
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

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

function config.lua_snip()
	local ls = require('luasnip')
	local types = require('luasnip.util.types')
	ls.config.set_config({
		history = true,
		enable_autosnippets = true,
		updateevents = 'TextChanged,TextChangedI',
		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { '<- choiceNode', 'Comment' } },
				},
			},
		},
	})
	require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
	require('luasnip.loaders.from_vscode').lazy_load()
	require('luasnip.loaders.from_vscode').lazy_load({
		paths = { './snippets/' },
	})
end

function config.typescript()
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

function config.lspsaga()
	require("lspsaga").setup()
end

return config
