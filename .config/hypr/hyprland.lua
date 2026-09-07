local scripts = os.getenv("HOME") .. "/.config/hypr/scripts/"

hl.monitor({
	output = "",
	mode = "preffered",
	position = "auto",
	scale = "2",
})

hl.on("hyprland.start", function()
	hl.exec_cmd("awww-daemon && dunst")
	hl.exec_cmd("wl-paste -t text -w xclip -selection clipboard") -- enable clipboard in wine apps
	hl.exec_cmd("eww open main & hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd(scripts .. "xdg-desktop.sh")
end)

local terminal = "kitty"
local fileManager = "nautilus"
local menu = "rofi -show drun"
local winMenu = "rofi -show window"
-- local browser = "firefox"

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- force electron base apps to run under wayland compositor
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")

hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,

		border_size = 0,

		allow_tearing = false,

		layout = "dwindle",
	},

	xwayland = {
		force_zero_scaling = true, -- prevent xwayland windows from scaling, good for games albion, wow, witcher...
	},

	animations = {
		enabled = false,
	},

	input = {
		kb_layout = "us,rs,rs",
		kb_variant = ", , latin",
		kb_options = "grp:alt_space_toggle",

		follow_mouse = 1,
		natural_scroll = true,

		repeat_rate = 50,
		repeat_delay = 200,
	},

	decoration = {
		rounding = 0,
		rounding_power = 0,
		dim_inactive = true,
		dim_strength = 0.5,
		dim_special = 0,
	},

	binds = {
		pass_mouse_when_bound = false,
		scroll_event_delay = 0,
		movefocus_cycles_fullscreen = true,
	},

	cursor = {
		enable_hyprcursor = true,
		zoom_rigid = false,
		zoom_factor = 1.0,
		zoom_detached_camera = false,
		no_hardware_cursors = true,
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
		enable_swallow = true,
		swallow_regex = "^(kitty)$",
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		focus_on_activate = false, -- focus browser when open a link from 3rd party app or telegram when recieve notification
	},
})

-- hl.animation({ leaf = "workspaces", enabled = false })
-- hl.animation({ leaf = "zoomFactor", enabled = false })
-- hl.animation({ leaf = "fadeSwitch", enabled = false })
-- hl.animation({ leaf = "windows", enabled = false })
-- hl.animation({ leaf = "fadeDim", enabled = false })
-- hl.animation({ leaf = "fadeIn", enabled = false })
-- hl.animation({ leaf = "fadeOut", enabled = false })

local mainMod = "SUPER"

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(winMenu))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("Telegram"))
-- screenshot
hl.bind("ALT + SHIFT + 1", hl.dsp.exec_cmd(scripts .. "screenshot.sh" .. " area"))
hl.bind("ALT + SHIFT + 2", hl.dsp.exec_cmd(scripts .. "screenshot.sh" .. " monitor"))
hl.bind("ALT + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(scripts .. "volume.sh" .. " --inc"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(scripts .. "volume.sh" .. " --dec"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(scripts .. "volume.sh" .. " --toggle"), { locked = true, repeating = true })
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

local MAX_ZOOM = 10
local MIN_ZOOM = 1
local ZOOM_STEP = 0.5

---@param offset number|nil
local function zoom(offset)
	local current = hl.get_config("cursor.zoom_factor") or MIN_ZOOM
	if offset ~= nil then
		current = current + offset
	else
		current = (current == MIN_ZOOM) and 1.5 or MIN_ZOOM
	end
	current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
	hl.config({ cursor = { zoom_factor = current } })
end

hl.bind("SUPER + mouse_down", function()
	zoom(-ZOOM_STEP)
end)

hl.bind("SUPER + mouse_up", function()
	zoom(ZOOM_STEP)
end)

hl.bind("SUPER + mouse:274", function()
	hl.config({ cursor = { zoom_factor = MIN_ZOOM } })
end)

hl.window_rule({
	name = "fleat google meet sharing indicator",
	match = {
		class = "^(meet.google.com)",
	},
	float = true,
})

-- i think this doesn't work...
hl.window_rule({
	name = "??",
	match = {
		title = "(Open File)",
	},
	float = true,
	center = true,
	size = { "monitor_w * 0.5", "monitor_h * 0.5" },
})

-- i think this doesn't work...
hl.window_rule({
	name = "??",
	match = {
		class = "^xdg-desktop-portal-gtk",
	},
	float = false,
	center = true,
	size = { "monitor_w * 0.5", "monitor_h * 0.1" },
})

hl.window_rule({
	name = "Picture in picture video floating at the edge of the screen",
	move = { "(monitor_w * 1)-window_w-10", "(monitor_h*1)-window_h-30" },
	size = { "400", "220" },
	rounding_power = 6.0,
	rounding = 10,
	no_focus = false,
	no_dim = true,
	dim_around = false,
	no_initial_focus = true,
	focus_on_activate = false,
	animation = "slide",
	no_anim = true,
	float = true,
	pin = true,
	workspace = "unset silent",
	match = {
		title = "Picture-in-Picture",
	},
})

hl.window_rule({
	name = "floating telegram files viewer",
	size = { "monitor_w * 0.5", "monitor_h * 0.5" },
	center = true,
	no_dim = true,
	float = true,
	match = {
		title = "^(Media viewer)",
		class = "^(org.telegram.desktop)",
	},
})

hl.window_rule({
	name = "focus browser when open a link",
	match = {
		class = "^(zen)$",
	},
	focus_on_activate = true,
})

hl.window_rule({
	name = "floating browser file picker",
	float = true,
	center = true,
	size = { "monitor_w * 0.5", "monitor_h * 0.5" },
	focus_on_activate = true,
	match = {
		class = "^(xdg-desktop-portal-gtk|xdg-desktop-portal-kde|xdg-desktop-portal-gnome)$",
	},
})

hl.window_rule({
	name = "floating viber client",
	float = true,
	center = true,
	size = { "monitor_w * 0.7", "monitor_h * 0.7" },
	focus_on_activate = true,
	match = {
		class = "viber",
		title = "Rakuten Viber",
	},
})

hl.window_rule({
	name = "floating nautilus",
	float = true,
	center = true,
	size = { "monitor_w * 0.7", "monitor_h * 0.7" },
	focus_on_activate = true,
	match = {
		class = "^(org.gnome.Nautilus)$",
	},
})

hl.window_rule({
	name = "floating water take reminder",
	float = true,
	center = true,
	size = { "monitor_w * 0.7", "monitor_h * 0.7" },
	focus_on_activate = true,
	match = {
		title = "^(Hydration Time)$",
	},
})

hl.window_rule({
	name = "inhibit idle on fullscreen",
	idle_inhibit = "fullscreen",
	match = {
		class = "^(mpv|vlc|steam_app_.*)$",
	},
})

hl.window_rule({
	name = "floating screen capture picker",
	float = true,
	center = true,
	match = {
		class = "^(hyprland-share-picker|xdg-desktop-portal-hyprland)$",
	},
})
