local status, typescript = pcall(require, "typescript")
if not status then
	return
end

typescript.setup({})
