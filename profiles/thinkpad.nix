{ pkgs, config, lib, ... }:

let

  theme = import ../layers/theme.nix {
    pkgs = pkgs;

    theme      = "gruvbox";
    variant    = "dark";
    fontFamily = "Fira Mono";
    fontSize   = 15;
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

  jvm = import ../layers/jvm.nix {
    pkgs = pkgs;
  };

  nodejs = import ../layers/nodejs.nix {
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
    pkgs            = pkgs;
    config          = config;
    lib             = lib;
    theme           = theme;
    extraGitIgnores = jvm.git.ignores;
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

  programs.home-manager.enable = true;
  services.lorri.enable = true;

  imports = [
    git.home
    bash.home
    alacritty.home
    neovim.home
    zsh.home
    tmux.home
    starship.home
  ];

  home = {
    username      = "david";
    homeDirectory = "/home/david";

    packages =
      devPackages ++
      base.packages ++
      cloudPlatforms.packages ++
      beam.packages ++
      ruby.packages ++
      rust.packages ++
      jvm.packages ++
      nodejs.packages ++
      git.packages ++
      dhall.packages ++
      bash.packages ++
      [ pkgs.ion ];

    sessionVariables = {
      PAGER     = "less -R";
      EDITOR    = "nvim";
      VISUAL    = "nvim";
      TERM      = "xterm-256color";
    };

    stateVersion = "20.09";
  };

}
