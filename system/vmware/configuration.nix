# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking.hostName = "eos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "US/Pacific";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    useDHCP = false;
    interfaces.ens33.useDHCP = true;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  services = {
    xserver = {
      enable = true;
      desktopManager.pantheon.enable = true;
    };

    pantheon = {
      apps.enable = true;
      contractor.enable = true;
    };
  };

  fonts.fonts = with pkgs; [
    (
      nerdfonts.override {
        fonts = [ "FiraCode" "DejaVuSansMono" "Hack" "IBMPlexMono" ];
      }
    )
  ];

  virtualisation = {
    docker.enable = true;

    # This is running inside a VM
    vmware.guest.enable = true;
  };

  # Mount `/mnt` for Shared Folders from the Host Machine
  fileSystems."/mnt" = {
    device = ".host:/";
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    options = [ "uid=1000" "gid=1000" "allow_other" "defaults" "auto_unmount" ];
  };

  # Enable Flatpak
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;

    extraUsers.davidlewis = {
      hashedPassword = "$6$Njc3WONFSurN$RCBNs7moPFyzwdXKOSKFZYpXtFKrOvZM8seZnPo5JQwSNJttOoZfmuQI745Sr/edXgqv7kiCx89olerMu1dEa.";
      isNormalUser = true;
      description = "David Armstrong Lewis";
      extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
      useDefaultShell = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    open-vm-tools
    vim
    wget
    firefox
    alacritty
  ];

  programs = {
    zsh.enable = true;
    pantheon-tweaks.enable = true;
  };

  system.stateVersion = "21.05"; # Did you read the comment?
}
