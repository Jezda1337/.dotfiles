# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ./modules
    ];

	stylix.enable = true;
	stylix.cursor.package = pkgs.banana-cursor;
	stylix.cursor.name = "Banana";
	stylix.cursor.size = 32;

	stylix.fonts = {
		monospace = {
			package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
			name = "JetBrainsMono Nerd Font Mono";
		};
		sansSerif = {
			# package = pkgs.dejavu_fonts;
			# name = "DejaVu Sans";
			package = pkgs.ubuntu-sans;
			name = "Ubuntu Sans";
		};
		serif = {
			package = pkgs.dejavu_fonts;
			name = "DejaVu Serif";
		};
	};

	stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruber.yaml";

	stylix.fonts.sizes = {
		applications = 12;
		terminal = 15;
		desktop = 10;
		popups = 10;
	};

	stylix.opacity = {
		applications = 1.0;
		terminal = 0.6;
		desktop = 1.0;
		popups = 1.0;
	};

	stylix.polarity = "dark";

	stylix.image = ../wallhaven-727mwo_1920x1080.png;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs = {
     config = {
       allowUnfree = true;
       packageOverrides = pkgs: {
         steam = pkgs.steam.override {
           extraPkgs = pkgs: with pkgs; [
             krb5.out 
             xorg.libXau.out 
             xorg.libXcomposite.out 
             xorg.libXdamage.out 
             xorg.libXdmcp.out 
             xorg.libXfixes.out 
             xorg.libXrandr.out 
             xorg.libXrender.out 
             xorg.libXtst.out 
           ];
         };
       };
     };
   };


	programs.nautilus-open-any-terminal.terminal = "kitty";
	services.gnome.sushi.enable = true;

	programs.steam.enable = true;
	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
		krb5.out 
		stdenv.cc.cc
		openssl
		xorg.libXcomposite
		xorg.libXtst
		xorg.libXrandr
		xorg.libXext
		xorg.libX11
		xorg.libXfixes
		libGL
		libva
		xorg.libxcb
		xorg.libXdamage
		xorg.libxshmfence
		xorg.libXxf86vm
		xorg.libXau
		libelf
		xorg.libXdmcp

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

		xorg.libXrandr
		xorg.libX11
		gcc.libc
		libGL
		zlib
		krb5.out
		glib
		nspr
		nss
		xorg.libXcomposite
		xorg.libXdamage
		xorg.libXext
		xorg.libXfixes
		xorg.libXrender
		xorg.libXtst
		freetype
		expat
		fontconfig
		#xorg.libX11_xcb
		dbus
		alsaLib
		xorg.libXau
		xorg.libXdmcp
		xorg.xrandr
		wlr-randr
	];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

	# run appimages easy from teriminal
	boot.binfmt.registrations.appimage = {
		wrapInterpreterInShell = false;
		interpreter = "${pkgs.appimage-run}/bin/appimage-run";
		recognitionType = "magic";
		offset = 0;
		mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
		magicOrExtension = ''\x7fELF....AI\x02'';
	};

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus24";
		#  keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
  };

	services.keyd = {
		enable = true;
		keyboards = {
			default = {
				ids = [ "*" ];
				settings = {
					main = {
						capslock = "overload(control, esc)";
					};
				};
			};
		};
	};

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.radoje = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      tree
      git
      brave
      vim
      wget
      kitty
      neovim
      nwg-panel
      pamixer
      slack	
      discord
			wofi
			cliphist
			wl-clipboard
			grim
			slurp
			android-studio
			android-studio-tools
			keyd
			nautilus
			sushi # preview for nautilus
			dolphin
			nemo
			xfce.thunar
			gh
			appimage-run
			fpm # Tool to build packages for multiple platforms with ease
			pkg-config
			alsa-lib
			alsa-tools
			clapper
			libxkbcommon # keyboard supp lib for wayland and manymore


      tor-browser
      proxychains

			gcc
			nodejs_22
			go
			gotools
    ];
  };

  programs.proxychains.enable = true;
  programs.proxychains.chain.type = "dynamic";
  programs.proxychains.proxies = {
	  tor = {
		  enable = true;
		  type = "socks5";
		  host = "127.0.0.1";
		  port = 9050;
	  };
  };
  services.tor = {
	  enable = true;
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
		# viber
  ];
  environment.variables.EDITOR = "vim";
	environment.variables = {
		#NIX_LD = lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
	};


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

