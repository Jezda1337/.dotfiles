return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		vim.o.formatexpr = "vim:lua.require'conform'.formatexpr()"
		require("conform").setup({
			format_on_save = function(bufnr)
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname:match("/node_modules/") then
					return
				end

				return { timeout_ms = 500, lsp_fallback = true, async = true }
			end,
			formatters_by_ft = {
				["javascript"] = { { "prettierd", "prettier" } },
				["javascriptreact"] = { { "prettierd", "prettier" } },
				["typescript"] = { { "prettierd", "prettier" } },
				["typescriptreact"] = { { "prettierd", "prettier" } },
				["vue"] = { { "prettierd", "prettier" } },
				["css"] = { { "prettierd", "prettier" } },
				["scss"] = { { "prettierd", "prettier" } },
				["less"] = { { "prettierd", "prettier" } },
				["html"] = { { "prettierd", "prettier" } },
				["json"] = { { "prettierd", "prettier" } },
				["jsonc"] = { { "prettierd", "prettier" } },
				["yaml"] = { { "prettierd", "prettier" } },
				["markdown"] = { { "deno_fmt", "prettierd", "prettier" } },
				["markdown.mdx"] = { { "deno_fmt", "prettierd", "prettier" } },
				["graphql"] = { { "prettierd", "prettier" } },
				["handlebars"] = { { "prettierd", "prettier" } },
				["lua"] = { { "stylua" } },
				["go"] = { { "goimports", "gofmt" } },
			},
		})
		require("conform.formatters.prettier").args = function(ctx)
			local args = { "--stdin-filepath", "$FILENAME" }
			local found = vim.fs.find(
				"~/.config/nvim/utils/linter-config/prettier.config.js",
				{ upward = true, path = ctx.dirname }
			)[1]
			if found then
				vim.list_extend(args, { "--config", found })
			end
			return args
		end
	end,
}
