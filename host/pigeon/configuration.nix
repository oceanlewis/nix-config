{
  pkgs,
  overlays,
  ...
}:
let
  HOST_NAME = "pigeon";
  USER = "ocean";
  HOME = "/Users/${USER}";
in
{
  nixpkgs.overlays = overlays;
  nixpkgs.config.allowUnfree = true;

  nix = {
    extraOptions = ''
      build-users-group = nixbld
      experimental-features = nix-command flakes
      extra-platforms = x86_64-darwin aarch64-darwin
      keep-outputs = true
      keep-derivations = true
    '';

    optimise = {
      automatic = true;
      interval = [
        {
          Hour = 7;
          Minute = 0;
        }
      ];
    };

    settings = {
      download-buffer-size = 134217728; # 2^27
      trusted-users = [ USER ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  networking = {
    computerName = HOST_NAME;
    hostName = HOST_NAME;
  };

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

    trackpad = {
      Clicking = true; # Tap-to-click
      TrackpadThreeFingerDrag = true;
    };

    NSGlobalDomain = {
      "com.apple.trackpad.scaling" = 3.0; # Trackpad tracking speed (0-3f)

      # Keyboard Settings
      InitialKeyRepeat = 15;
      KeyRepeat = 2;

      # Grammatical Help Settings
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };

    alf = {
      globalstate = 1; # Prevent unauthorized incoming requests
      stealthenabled = 1; # Ignore incoming ICMP traffic (pings, etc.)
    };

    dock = {
      autohide = true;
      mineffect = "scale"; # Minimize to dock settings
      mru-spaces = false; # Don't automatically rearrange spaces
    };
  };

  fonts.packages = import ../../layers/fonts.nix { inherit pkgs; };

  users.users."${USER}" = {
    home = HOME;
    isHidden = false;
    shell = pkgs.zsh;

    packages = with pkgs; [
      ollama
    ];
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };

    taps = [ ];

    masApps = {
      "Craft: Write docs, AI editing" = 1487937127;
      "1Password for Safari" = 1569813296;
      "Things 3" = 904280696;
    };

    brews = [
      "mas"
    ];

    casks = [
      "1password"
      "chatgpt"
      "discord"
      "docker"
      "firefox"
      "handbrake"
      "jordanbaird-ice"
      "lunar"
      "notion"
      "raycast"
      "rectangle-pro"
      "spotify"
      "steam"
      "thingsmacsandboxhelper"
      "transmission"
      "utm"
      "visual-studio-code"
      "vlc"
      {
        name = "wezterm@nightly";
        greedy = true;
      }
      "zen-browser"
    ];
  };

  environment = with pkgs; {
    systemPackages = [
      ncurses
      nushell
      zsh

      # Apple Shortcuts
      # - "Set the default browser"
      defaultbrowser
    ];
    shells = [
      nushell
      zsh
    ];
    shellAliases = { };
    variables = { };

    loginShellInit = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };

  services = {
    nix-daemon.enable = true;
    lorri.enable = true;
  };

  programs.zsh = {
    enable = true;

    loginShellInit = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
