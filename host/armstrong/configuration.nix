{
  pkgs,
  overlays,
  ...
}:
let
  HOST_NAME = "Armstrong";
  USER = "ocean.lewis";
  HOME = "/Users/${USER}";
in
{
  nixpkgs.overlays = overlays;

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

  security.pam.services.sudo_local.touchIdAuth = true;

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

    CustomUserPreferences = {
      "com.microsoft.VSCode".ApplePressAndHoldEnabled = false;
      "com.microsoft.VSCodeInsiders".ApplePressAndHoldEnabled = false;
    };
  };

  fonts.packages = import ../../layers/fonts.nix { inherit pkgs; };

  users.users."${USER}" = {
    home = HOME;
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      # cleanup = "zap";
    };

    taps = [
      "homebrew/cask-versions"
      "hginsights/tap"
      "hcavarsan/kftray"
    ];

    masApps = {
      "Craft: Write docs, AI editing" = 1487937127;
    };

    brews = [
      "awscli"
      "gimme-aws-creds"
      "hginsights/tap/gimme-snowflake-creds"
      "kubernetes-cli"
      "kubectx"
      {
        name = "kftray";
        args = [ "HEAD" ];
        link = true;
      }
      "mas"
    ];

    casks = [
      "arc"
      "chatgpt"
      "equinox"
      "librewolf"
      "google-chrome"
      "handbrake"
      "jordanbaird-ice"
      "lunar"
      "mimestream"
      "raycast"
      "rectangle-pro"
      "sfdx"
      "slack"
      "transmission"
      "utm"
      "visual-studio-code"
      "visual-studio-code@insiders"
      "vlc"
      {
        name = "wezterm@nightly";
        greedy = true;
      }
      "zen-browser"
      "zoom"
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
    shellAliases = {
      hg = ''cd "${HOME}/Developer/hg"'';
    };
    variables = { };

    loginShellInit = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };

  services = {
    lorri.enable = true;

    redis = {
      enable = false;
      dataDir = "${HOME}/.redis";
    };

    postgresql = {
      enable = false;
      package = pkgs.postgresql_14;
      dataDir = "${HOME}/.postgresql_14";
    };
  };

  programs.zsh = {
    enable = true;

    loginShellInit = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  ids.gids.nixbld = 350;
  system.stateVersion = 4;
}
