local M = {}

function M.servers()
	return {
		"astro",
		"bashls",
		"cssls",
		"eslint",
		"gopls",
		"html",
		"jsonls",
		"rust_analyzer",
		"tailwindcss",
		"svelte",
		"volar",
		"yamlls",
		"prismals",
		"dockerls",
		-- "denols",
		"graphql",
	}
end

return M
