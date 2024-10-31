return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	opts = {
		templ = {},
		formatters_by_ft = {
			lua = { "stylua" },
			-- stop_after_first = Only run the first available formatter in the list
			javascript = { "prettierd", "prettier", stop_after_first = true },
			vue = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			scss = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			go = { "gofmt", "goimports", stop_after_first = false },
			-- templ = { inherit = false, command = "templ", args = { "fmt", "-filename", "$FILENAME" } },
		},

		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
-- return {
-- 	"elentok/format-on-save.nvim",
-- 	config = function()
-- 		local format_on_save = require("format-on-save")
-- 		local formatters = require("format-on-save.formatters")
--
-- 		-- Looking for local prettier configs, if ther is none, then relay on my custom one.
-- 		local cwd = vim.uv.cwd()
-- 		local file = vim.fs.find(function(name, _)
-- 			return name:match(".prettierrc.*")
-- 		end, { limit = 1, type = "file", path = cwd })
--
-- 		local function customPrettierConfig()
-- 			if file[1] ~= nil then
-- 				return formatters.prettierd
-- 			else
-- 				return formatters.shell({
-- 					cmd = {
-- 						"prettier",
-- 						"--config ~/.dotfiles/.config/nvim/format-configs/.prettierrc.yaml",
-- 						"--stdin-filepath",
-- 						"%",
-- 					},
-- 				})
-- 			end
-- 		end
--
-- 		format_on_save.setup({
-- 			exclude_path_patterns = {
-- 				"/node_modules/",
-- 				".local/share/nvim/lazy",
-- 			},
-- 			formatter_by_ft = {
-- 				css = customPrettierConfig(),
-- 				astro = formatters.lsp or customPrettierConfig(),
-- 				html = customPrettierConfig(),
-- 				javascript = customPrettierConfig(),
-- 				json = customPrettierConfig(),
-- 				-- vue = customPrettierConfig(),
-- 				vue =
-- 				lua = formatters.stylua,
-- 				markdown = customPrettierConfig(),
-- 				python = formatters.black,
-- 				rust = formatters.lsp,
-- 				scss = customPrettierConfig(),
-- 				sh = formatters.shfmt,
-- 				typescript = customPrettierConfig(),
-- 				typescriptreact = customPrettierConfig(),
-- 				yaml = formatters.lsp,
-- 				go = {
-- 					formatters.shell({ cmd = { "goimports" } }),
-- 					formatters.shell({ cmd = { "gofmt" } }),
-- 				},
-- 				--templ = customPrettierConfig() or formatters.lsp,
-- 			},
-- 		})
-- 	end,
-- }
