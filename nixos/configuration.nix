{ config, pkgs, lib, ... }:
let
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  stateVersion = "23.05"; # Did you double check?
  nameservers = [ "1.1.1.1" "8.8.8.8"];
in
 {
  imports =
    [
      ./hardware-configuration.nix
      ./hosts.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "errata";
  services.resolved.enable = true;
  services.sshd.enable = true;
  services.openssh.settings.X11Forwarding = true;
  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
	enable = true;
	desktopManager = {
		xterm.enable = false;
	};
	displayManager = {
	  defaultSession = "none+i3";
	  startx = {
	    enable = true;
          };	
	};
	windowManager.i3 = {
	  enable = true;
	  extraPackages = with pkgs; [
	    dmenu
	  ];  
        };
  };

  networking.nameservers = nameservers;
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  documentation.man = {
    enable = true;
    generateCaches = true;
  };

  virtualisation.docker = {
	enable = true;
  };

  virtualisation.docker.daemon.settings = {
    dns = nameservers;
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.docker.rootless.daemon.settings = {
    dns = nameservers;
  };


  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "slack" "discord" "nvidia-x11" "nvidia-settings" "nvidia-persistenced"
  ];

  nixpkgs.config.nvidia.acceptLicense = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # slack screensharing
  
  # GPU
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users.baykovr = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "docker" ];
    packages = with pkgs; [
      firefox
      tree
      jq
      tldr
    ];
    initialPassword = "toor";
  };

  environment.systemPackages = with pkgs; [
    lxappearance
    vim 
    file
    wget
    git
    qemu
    compsize
    efibootmgr
    xterm
    duf
    zoxide 
    btop

    # Wayland Only
    sway
    mako 
    bemenu
    wl-clipboard 
    wdisplays
    
    gpu-screen-recorder
    
    python3
    go
    dig

    # nonfree
    pkgs.discord
    pkgs.slack
  ];

  programs.thunar = {
    enable = true;
  };

  # Compositor.
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Allow screen sharing.
  services.dbus = {
    enable = true;
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };


  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options  = [ "compress=zstd" "noatime" ];
  };

  system.stateVersion = "${stateVersion}";
 }
