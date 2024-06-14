---@param file_name string
---@return nil or File
return function(file_name)
	if type(file_name) ~= "string" then
		return nil
	end

	local file = vim.fs.find(function(name, path)
		if path:match("node_modules") then
			return false
		end
		return name:match(file_name)
	end, { limit = 1, type = "file", path = "." })

	if file[1] ~= nil then
		return true
	else
		return false
	end
end
