local uv = vim.loop
local path = "/home/radoje/.config/nvim/index.html"

local function on_file_change()
	print("File changed!")
	-- Add your logic here to handle the file change

	-- Restart the watcher after each change
	watcher:stop()
	watcher:start(path, { recursive = false }, function(err, filename, events)
		assert(not err, err)
		if events["change"] then
			on_file_change()
		end
	end)
end

local function setup_file_watcher(file_path)
	local watcher = uv.new_fs_event()

	watcher:start(file_path, { recursive = false }, function(err, filename, events)
		assert(not err, err)
		if events["change"] then
			on_file_change()
		end
	end)

	return watcher
end

local function attach_file_watcher(file_path)
	watcher = setup_file_watcher(file_path)

	-- Cleanup on exit
	vim.cmd([[autocmd VimLeavePre * lua require'your_module'.cleanup_watcher()]])
end

function cleanup_watcher()
	watcher:stop()
	watcher:close()
end

-- Example usage:
attach_file_watcher(path)
