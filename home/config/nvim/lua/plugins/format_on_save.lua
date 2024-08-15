return {
	"elentok/format-on-save.nvim",
	config = function()
		local format_on_save = require("format-on-save")
		local formatters = require("format-on-save.formatters")

		-- Looking for local prettier configs, if ther is none, then relay on my custom one.
		local cwd = vim.uv.cwd()
		local file = vim.fs.find(function(name, _)
			return name:match(".prettierrc.*")
		end, { limit = 1, type = "file", path = cwd })

		local function customPrettierConfig()
			if file[1] ~= nil then
				return formatters.prettierd
			else
				return formatters.shell({
					cmd = {
						"prettier",
						"--config ~/.dotfiles/.config/nvim/format-configs/.prettierrc.yaml",
						"--stdin-filepath",
						"%",
					},
				})
			end
		end

		format_on_save.setup({
			exclude_path_patterns = {
				"/node_modules/",
				".local/share/nvim/lazy",
			},
			formatter_by_ft = {
				css = customPrettierConfig(),
				astro = formatters.lsp or customPrettierConfig(),
				html = customPrettierConfig(),
				javascript = customPrettierConfig(),
				json = customPrettierConfig(),
				vue = customPrettierConfig(),
				lua = formatters.stylua,
				markdown = customPrettierConfig(),
				python = formatters.black,
				rust = formatters.lsp,
				scss = customPrettierConfig(),
				sh = formatters.shfmt,
				typescript = customPrettierConfig(),
				typescriptreact = customPrettierConfig(),
				yaml = formatters.lsp,
				go = {
					formatters.shell({ cmd = { "goimports" } }),
					formatters.shell({ cmd = { "gofmt" } }),
				},
			},
		})
	end,
}
