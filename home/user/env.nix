{ lib, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "brave";
    TERMINAL = "kitty";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_SCALE_FACTOR = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland-egl";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    GTK_CSD = "0";
    # WLR_DRM_DEVICES = "/dev/dri/card0";
    # WLR_NO_HARDWARE_CURSORS = "1"; 
    CLUTTER_BACKEND = "wayland";
    # WLR_RENDERER = "vulkan";
    XCURSOR_SIZE = "32";
    # GTK_THEME="Catppuccin-Macchiato-Compact-Blue-Dark";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";

		STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";

		NIX_LD_LIBRARY_PATH = with pkgs; lib.makeLibraryPath [
			openssl
			xorg.libXcomposite
			xorg.libXtst
			xorg.libXrandr
			xorg.libXext
			xorg.libX11
			xorg.libXfixes
			libGL
			libva
			#pipewire.lib
			xorg.libxcb
			xorg.libXdamage
			xorg.libxshmfence
			xorg.libXxf86vm
			libelf

			xorg.libX11.out
			xorg.libXfixes.out
			xorg.libXi.out
			xorg.libXrender.out
			xorg.libXxf86vm.out
			xorg_sys_opengl.out

			# Required
			glib
			gtk2
			bzip2

			# Without these it silently fails
			xorg.libXinerama
			xorg.libXcursor
			xorg.libXrender
			xorg.libXScrnSaver
			xorg.libXi
			xorg.libSM
			xorg.libICE
			gnome2.GConf
			nspr
			nss
			cups
			libcap
			SDL2
			libusb1
			dbus-glib
			ffmpeg
			# Only libraries are needed from those two
			libudev0-shim

			# Verified games requirements
			xorg.libXt
			xorg.libXmu
			libogg
			libvorbis
			SDL
			SDL2_image
			glew110
			libidn
			tbb

			# Other things from runtime
			flac
			freeglut
			libjpeg
			libpng
			libpng12
			libsamplerate
			libmikmod
			libtheora
			libtiff
			pixman
			speex
			SDL_image
			SDL_ttf
			SDL_mixer
			SDL2_ttf
			SDL2_mixer
			libappindicator-gtk2
			libdbusmenu-gtk2
			libindicator-gtk2
			libcaca
			libcanberra
			libgcrypt
			libvpx
			librsvg
			xorg.libXft
			libvdpau
			gnome2.pango
			cairo
			atk
			gdk-pixbuf
			fontconfig
			freetype
			dbus
			alsaLib
			expat
			# Needed for electron
			libdrm
			mesa
			libxkbcommon
		];
		#NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
	};
}
