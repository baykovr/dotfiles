{ config, pkgs, lib, ... }:
let
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  stateVersion = "23.05"; # Did you double check?
in
 {
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "errata";
  services.resolved.enable = true;

  networking.networkmanager.enable = true;  
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "slack" "discord"
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # slack screensharing

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users.baykovr = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "docker" ];
    packages = with pkgs; [
      firefox
      tree
      awscli2
      jq
      tldr
    ];
    initialPassword = "toor";
  };

  environment.systemPackages = with pkgs; [
    vim 
    file
    wget
    git
    qemu
    compsize
    efibootmgr
    xterm
    exa
    duf
    zoxide 
    btop

    wayshot
    sway
    mako 
    bemenu
    wl-clipboard 
    wdisplays

    # nonfree
    pkgs.discord
    pkgs.slack
    
    python3
    go
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

  xdg.portal.wlr.enable = true; 

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options  = [ "compress=zstd" "noatime" ];
  };

  system.stateVersion = "${stateVersion}";
 }
