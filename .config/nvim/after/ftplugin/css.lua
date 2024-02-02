local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true -- without this there is no completion
-- local capabilities = require("cmp_nvim_lsp").default_capabilities() -- doesn't work
vim.lsp.start({
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_dir = vim.fs.dirname(vim.fs.find({ "package.json", ".git" }, { upward = true })[1]),
	single_file_support = true,
	capabilities = capabilities,
	settings = {
		css = {
			validate = true,
			lint = { unknownAtRules = "ignore" } -- ignore @ rules like @tailwind
		},
		scss = { validate = true },
		less = { validate = true },
	},
	default_config = {
		root_dir = [[root_pattern("package.json", ".git") or bufdir]],
	},
})
