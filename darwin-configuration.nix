{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./tmux.nix
    # ./term_status.nix
  ];

  environment.systemPackages = [
    pkgs.openssl
    pkgs.go
    pkgs.yarn
    pkgs.rustup
    pkgs.gcc
    pkgs.gnumake
    pkgs.pkgconfig

    pkgs.coreutils
    pkgs.curl
    pkgs.wget
    pkgs.git
    pkgs.git-lfs
    pkgs.xz
    pkgs.htop
    pkgs.exa
    pkgs.bat
    pkgs.ripgrep
    pkgs.fd
    pkgs.entr

    pkgs.vim
    pkgs.jq
    pkgs.httpie

    pkgs.gnupg
    pkgs.awscli
    pkgs.pgcli

    pkgs.alacritty
    pkgs.vscode
    pkgs.reattach-to-user-namespace
  ];

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    defaults = {
      dock = {
        autohide = true;
        mineffect = "scale";
        show-recents = false;
        static-only = true;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };

      NSGlobalDomain = {
        AppleShowScrollBars = "WhenScrolling";
        NSAutomaticQuoteSubstitutionEnabled = false;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
      };
    };
  };

  environment.variables = {
    PAGER = "less -R";
    EDITOR = "vim";
  };

  environment.shellAliases = {
  #   ls = "ls -G";
  #   rm = "rm -i";
  #   cp = "cp -i";
  #   gows = "cd $GOWORKSPACE";
    ls = "exa";
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs = {
    bash.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = builtins.readFile ./config/config.fish;
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 8;
  nix.buildCores = 8;
}
