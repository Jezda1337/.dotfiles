require("core")
vim.g.netrw_localrmdir = "rm -r" -- allow netrw to delete directories

local uv = vim.uv
local event = uv.new_fs_event()
local path = "/home/radoje/.config/nvim/index.html"
event:start(path, {
	watch_entry = true,
	stat = true,
	recursive = true,
}, function(err, filename, events)
	if err then
		print("Error: ", err)
		event:stop()
	end
	print(string.format("Change detected in %s", uv.fs_event_getpath(event))) -- get the file name path
	for k, v in pairs(events) do
		print("-------")
		print(k, v)
		print("-------")
	end
	print("file changed:" .. (filename and filename or ""))
end)

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
