{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware-configuration.nix
    ./components/pantheon-desktop.nix
    ./components/udev-stf32discovery.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  # Set your time zone.
  time.timeZone = "US/Pacific";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    hostName = "eos";

    useDHCP = false;
    interfaces.ens33.useDHCP = true;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  services.avahi = {
    enable = true;
    ipv4 = true;
    ipv6 = true;
    nssmdns = true;
    publish = {
      enable = true;
      domain = true;
      addresses = true;
    };
  };

  services.xserver.layout = "us";

  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      inter
      open-sans
      roboto-mono
      (
        nerdfonts.override {
          fonts = [ "FiraCode" "DejaVuSansMono" "Hack" "IBMPlexMono" ];
        }
      )
    ];
  };

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

  services.openssh = {
    enable = true;
    allowSFTP = true;
    passwordAuthentication = false;
    forwardX11 = true;
  };

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

      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDG7RSPfyioSL+/eh3QF8XKP9ddHBshXT+jfhyJoHHcyhwZvUuz3x8C/sWZbYhAJtUDmcZvBChlsry9//rwzz05NoRfCutwMhkbhca+3qa5Tk7to1O6givyQCg3LYP5XGn7bwLBUDumJnORBpeM+ik7fUcBbw1fFYqcU5xKnTOT0wbzEkWVjHTSgdca31CnwlLbw5XKKQARZ7vjaVlJBhAbNFk5rQEPNF1kp19RQyshORZu16a7NWxAJfFQs3JblUfGYfYi/b9j1msXXTkmE67jmcwjOohZmBB/pamlcDoNvQDZADemNS1MaatweimemophvnZEKs1sfXjNc2CMP3wRTWbprcYM6hKsXCq+NBuERm6Bz/w0f679nNY1YKMAJqHLLkvHdFGKCioSFH9vCSYNHrzFwvniihRzWqoeMkJ5WEUFT64xnpb/5c1BK4tvoVQlC++qRg4UYx+7kfGUYjru0QwvkxnTGw6xIqe71/7TdE0id1d5xx4SyqvJ7eeMJK3foR9Q7qkVNk6/pSH9ahAzZMKk45aZDzFe/kvlIMuHgCC9RV3uz7eaf+dTeZN8qsCzx7reL0+n5CKuF7bmwWWiujeBHg/WaweaBmg8/zFzuHlOwkkj6agLx9ySiUHdBunisXdJ96u1xRiwXRTJOA1D8TVwUKo68qXOorKd6FIRnQ== davidlewis@Thinky.attlocal.net"
      ];
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
  };

  system.stateVersion = "21.05";
}
