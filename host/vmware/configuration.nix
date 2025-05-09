{
  config,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    extra-experimental-features = [ "nix-command" "pipe-operators" ];
  };

  imports = [
    ./hardware-configuration.nix
    ./components/pantheon-desktop.nix
    ./components/udev-stf32discovery.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.grub.device = "/dev/disk/by-id/ata-VMware_Virtual_IDE_CDROM_Drive_10000000000000000001";
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
  services.xserver.videoDrivers = [
    "vmware"
    "amdgpu"
    "radeon"
    "nouveau"
    "modesetting"
    "fbdev"
  ];

  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      inter
      open-sans
      roboto-mono
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "DejaVuSansMono"
          "Hack"
          "IBMPlexMono"
        ];
      })
    ];
  };

  services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
    '';
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
    options = [
      "uid=1000"
      "gid=1000"
      "allow_other"
      "defaults"
      "auto_unmount"
    ];
  };

  # Enable Flatpak
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.openssh = {
    enable = true;
    allowSFTP = true;
    passwordAuthentication = false;
    forwardX11 = true;
  };

  environment.systemPackages = with pkgs; [
    open-vm-tools
    vim
    wget
    librewolf
    alacritty
  ];

  programs = {
    zsh.enable = true;
  };

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;

    extraUsers.ocean = {
      hashedPassword = "$6$tqrKEXT2FY/km7kj$t/1ONmxKdfRLcdzMZxRqjxp71btl/6seF47I/zPMFPsPhn0wYXcgg32bds86uHZfQDTRQ.bz4UwhMhdbWDgPD0";
      isNormalUser = true;
      description = "Ocean Armstrong Lewis";
      extraGroups = [
        "wheel"
        "networkmanager"
        "audio"
        "video"
        "docker"
      ];
      useDefaultShell = true;

      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDY3VommjB1Rohr5isKneHg5JhXxGS13BJfjH1IPNuvvOvn67oxUWxyrsnilBv/Ou+p+iQEkrJnBnRKj8mUMCtnTmQTrqq1JRbpE1brm1S/3F9uHW9CwrhbCYUAjhqc+mSNHPMfWfeC/15JotZFkBkiCu02ROOPEJNNqAnuWydPJqZrldJG1TM9qBQGerqHu0Tt6gQLEcD0QIldKsDJrpFvAygtETh5OJjunwTxqJO1fo1NUHYEvQczEANNyfvWiKJuvNv3a6sM/b1OpDaqKjt4HPUNIfbCH9ZX+1kJ6fY6/nXapQjiGyULKQbV4BvDd6+RSxGNgpsw4Qs2qA/CD387yHsSPIpMDKz/g05e8H077Ud/dwvkzPZHm4rTJ0qjHuiIhQc0vMSLnIXinuOP3X3rL2WgzEepsg1ke6rcajyIBJBxEPovkp49N5t8mBvfA9IGXaUtWCRewBPjsn3xyD3uS2NQChaFJ3XdBnua8jqDTk8fZnszAdHze/mR1KwX4Ina2yFHHv/9ncPmkSxklRLudhVP3Y3xNdAJmxUPZQNs6Q4T4qjm7GVpz6hgiKP6wLFlpVXxasADOFpknzh9aMRXcIxOJLfldMlJhBL1wOeTMx9IbWoezljLcEOh+o1e0GmreRYTVUreiqooNzrLNu78nIFXhSLQmeRJdmqamMRXLw== armstrong@Wizard"
      ];
    };
  };

  system.stateVersion = "21.11"; # Did you read the comment?
}
