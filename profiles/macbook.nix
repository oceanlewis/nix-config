{ config, pkgs, lib, ... }:

let

  USER = "davidlewis";
  HOME = "/Users/${USER}";

  theme = import ../layers/theme.nix {
    pkgs = pkgs;

    theme   = "gruvbox";
    variant = "light";
    font    = "menlo";
  };

  base = import ../layers/base.nix {
    pkgs = pkgs;
  };

  devPackages = import ../layers/dev-packages.nix {
    pkgs = pkgs;
  };

  cloudPlatforms = import ../layers/cloud-platforms.nix {
    pkgs = pkgs;
  };

  beam = import ../layers/beam.nix {
    pkgs = pkgs;
  };

  ruby = import ../layers/ruby.nix {
    pkgs = pkgs;
  };

  rust = import ../layers/rust.nix {
    pkgs = pkgs;
  };

  dhall = import ../layers/dhall.nix {
    pkgs = pkgs;
  };

  bash = import ../programs/bash.nix {
    pkgs   = pkgs;
    config = config;
    lib    = lib;
  };

  git = import ../programs/git/git.nix {
    pkgs   = pkgs;
    config = config;
    lib    = lib;
    theme  = theme;
  };

  alacritty = import ../programs/alacritty.nix {
    pkgs   = pkgs;
    config = config;
    lib    = lib;
    theme  = theme;
  };

  neovim = import ../programs/neovim.nix {
    pkgs   = pkgs;
    config = config;
    lib    = lib;
    theme  = theme;

    extraPlugins = dhall.vimPlugins;
  };

  zsh = import ../programs/zsh.nix {
    pkgs   = pkgs;
    config = config;
    lib    = lib;
  };

  tmux = import ../programs/tmux.nix {
    pkgs   = pkgs;
    config = config;
    lib    = lib;
  };

  starship = import ../programs/starship.nix {
    pkgs   = pkgs;
    config = config;
    lib    = lib;
  };

in

{

  home = {
    username      = USER;
    homeDirectory = HOME;

    packages =
      devPackages ++
      base.packages ++
      cloudPlatforms.packages ++
      beam.packages ++
      ruby.packages ++
      rust.packages ++
      git.packages ++
      dhall.packages ++
      bash.packages;

    sessionVariables = {
      PAGER           = "less -R";
      EDITOR          = "nvim";
      VISUAL          = "nvim";
      TERM            = "xterm-256color";
      XDG_CONFIG_HOME = "${HOME}/.config";
      XDG_DATA_HOME   = "${HOME}/.local/share";
      XDG_DATA_DIRS   = "${HOME}/.local/data";
      XDG_RUNTIME_DIR = "${HOME}/.local/run";
      BAT_THEME       = theme.bat.theme;
    };

    stateVersion = "20.09";
  };

  programs.home-manager.enable = true;

  imports = [
    git.home
    bash.home
    alacritty.home
    neovim.home
    zsh.home
    tmux.home
    starship.home
  ];

}
