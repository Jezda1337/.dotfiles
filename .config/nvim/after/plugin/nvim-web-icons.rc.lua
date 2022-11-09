local status, icons = pcall(require, "nvim-web-devicons")
if not status then
	return
end

icons.set_icon({
	astro = {
		icon = "",
		color = "#ff7e33",
		name = "astro",
	},
})
