require("core")
vim.g.netrw_localrmdir = "rm -r" -- allow netrw to delete directories

-- local cwd = vim.uv.cwd()

-- local fd = vim.uv.fs_scandir(cwd)
-- if fd then
-- 	while true do
-- 		local name, type = vim.uv.fs_scandir_next(fd)
-- 		if name == nil then
-- 			break
-- 		end

-- 		print(name, type)
-- 	end
-- end
