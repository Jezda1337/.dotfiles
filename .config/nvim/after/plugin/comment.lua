local status, comment = pcall(require, "Comment")
if not status then
	return
end

local file_types = {
	"lua",
	"js",
	"ts",
	"tsx",
	"vue",
	"py",
	"c",
	"go",
	"css",
	"scss",
}

comment.setup({
	ignore = function()
		-- ignore empy lines for the file types from above
		for _, v in ipairs(file_types) do
			if vim.bo.filetype == v then
				return "^$"
			end
		end
	end,
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
