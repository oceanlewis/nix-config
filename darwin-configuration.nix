{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ #( pkgs.lua.withPackages (ps: with ps; [ luarocks mpack ]) )
      #( pkgs.python36.withPackages (ps: with ps; [ pip flake8 yapf black pynvim python-language-server.override { pylint = null; } ]) )
      pkgs.openssl
      pkgs.go
      pkgs.yarn

      pkgs.coreutils
      pkgs.curl
      pkgs.wget
      pkgs.git
      pkgs.xz
      pkgs.htop
      pkgs.exa
      pkgs.bat
      pkgs.ripgrep
      pkgs.fd

      pkgs.vim
      pkgs.tmux
      pkgs.jq
      pkgs.httpie

      pkgs.awscli
      pkgs.pgcli
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  # programs.zsh.enable = true;
  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 8;
  nix.buildCores = 8;
}
