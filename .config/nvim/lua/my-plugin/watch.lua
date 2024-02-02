local uv = vim.loop

local FileWatcher = {}

function FileWatcher.new(file_path, callback)
	local self = setmetatable({}, { __index = FileWatcher })
	self.file_path = file_path
	self.callback = callback
	self.watcher = uv.new_fs_event()

	print("---------")
	print(self.file_path)
	print("---------")

	self:start_watching()
	self:setup_cleanup()

	return self
end

function FileWatcher:start_watching()
	self.watcher:start(self.file_path, { recursive = false }, function(err, filename, events)
		assert(not err, err)
		if events["change"] then
			self.callback()
		end
	end)
end

function FileWatcher:restart_watching()
	self.watcher:stop()
	self:start_watching()
end

function FileWatcher:setup_cleanup()
	-- vim.cmd([[autocmd VimLeavePre * lua require'your_module'.cleanup_watcher()]])
end

function FileWatcher:cleanup()
	self.watcher:stop()
	self.watcher:close()
end

-- -- Example usage:
-- local file_to_watch = "path/to/your/file.txt"
-- local myWatcher = FileWatcher.new(file_to_watch, function()
-- 	print("File changed!")
-- 	-- Add your logic here to handle the file change
-- 	myWatcher:restart_watching()
-- end)

return FileWatcher

-- Cleanup on exit (optional, as Lua garbage collector should handle it)
-- vim.cmd([[autocmd VimLeavePre * lua myWatcher:cleanup()]])
