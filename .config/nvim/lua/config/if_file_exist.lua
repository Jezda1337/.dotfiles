---@param file_name string
---@return nil or File
return function(file_name)
	if type(file_name) ~= "string" then
		return nil
	end

	local cwd = vim.uv.cwd()

	local file = vim.fs.find(function(name, _path)
		return name:match(file_name)
	end, { limit = 1, type = "file", path = cwd })

	if file[1] ~= nil then
		return true
	else
		return false
	end
end
