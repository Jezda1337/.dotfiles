require("core")
vim.g.netrw_localrmdir = "rm -r" -- allow netrw to delete directories

-- local newfs = vim.uv.new_fs_event()
-- local i = 0
-- vim.uv.fs_event_start(
-- 	newfs,
-- 	vim.uv.cwd(),
-- 	{ watch_entry = true, stat = true },
-- 	function(err, filename, events)
-- 		if err ~= nil then
-- 			return
-- 		end

-- 		print(filename)

-- 		i = i + 1
-- 		print(i)

-- 		if i >= 5 then
-- 			i = 0
-- 		end
-- 	end
-- )

-- local scan = require("plenary.scandir")
-- local rootDir = scan.scan_dir(".", {
-- 	hidden = true,
-- 	add_dirs = true,
-- 	depth = 1,
-- 	respect_gitignore = true,
-- 	search_pattern = function(entry)
-- 		local subEntry = string.sub(entry, 3)
-- 		-- print(subEntry)
-- 		print(subEntry:match(".git"))
-- 		-- "%f[%a]git%f[^%a]"
-- 		return subEntry:match(".git") or subEntry:match("package.json")
-- 	end,
-- })

-- print(vim.inspect(rootDir))

-- local hasValue = function(tbl)
-- 	local new_tbl = {}
-- 	for _, v in ipairs(tbl) do
-- 		print(v)
-- 		if v == "git" or v == "package.json" then
-- 			table.insert(new_tbl, v)
-- 		end
-- 	end

-- 	return vim.tbl_contains(rootDir, "./.git") or vim.tbl_contains(rootDir, "./package.json")
-- end

-- print(vim.inspect(hasValue(rootDir)))
