local M = {}

local watch = require("my-plugin.watch")

M.setup = function()
	local files = {
		"/home/radoje/Desktop/github/testing/index.html",
		"/home/radoje/Desktop/github/testing/test.html",
		"/home/radoje/Desktop/github/testing/test2.html",
	}

	local watch_files = {}

	for i, file in ipairs(files) do
		local watch_file = watch.new(file, function()
			print("File changed:", file)
			watch_files[i]:restart_watching()
		end)

		table.insert(watch_files, watch_file)
	end
end

return M
