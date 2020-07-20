{ config, pkgs, lib, ... }:

let

  theme = import ../layers/theme.nix {
    inherit pkgs;

    theme      = "standard";
    variant    = "light";
    fontFamily = "Menlo";
    fontSize   = 15;
  };

  base = import ../layers/base.nix {
    inherit pkgs;
  };

  devPackages = import ../layers/dev-packages.nix {
    inherit pkgs;
  };

  cloudPlatforms = import ../layers/cloud-platforms.nix {
    inherit pkgs;
  };

  beam = import ../layers/beam.nix {
    inherit pkgs;
  };

  ruby = import ../layers/ruby.nix {
    inherit pkgs;
  };

  rust = import ../layers/rust.nix {
    inherit pkgs;
  };

  jvm = import ../layers/jvm.nix {
    inherit pkgs;
  };

  nodejs = import ../layers/nodejs.nix {
    inherit pkgs;
  };

  dhall = import ../layers/dhall.nix {
    inherit pkgs;
  };

  bash = import ../programs/bash.nix {
    inherit pkgs config lib;
  };

  git = import ../programs/git/git.nix {
    inherit pkgs config lib theme;
    extraGitIgnores = jvm.git.ignores;
  };

  alacritty = import ../programs/alacritty.nix {
    inherit pkgs config lib theme;
  };

  neovim = import ../programs/neovim.nix {
    inherit pkgs config lib theme;
    extraPlugins = dhall.vimPlugins;
  };

  zsh = import ../programs/zsh.nix {
    inherit pkgs config lib;
  };

  tmux = import ../programs/tmux.nix {
    inherit pkgs config lib;
  };

  starship = import ../programs/starship.nix {
    inherit pkgs config lib;
  };

  lorri = import ../services/lorri.nix {
    inherit pkgs config lib;
  };

  USER = "davidlewis";
  HOME = "/Users/${USER}";

in

{

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
      jvm.packages ++
      nodejs.packages ++
      git.packages ++
      dhall.packages ++
      bash.packages ++
      lorri.packages ++ [ pkgs.lorri ];

    sessionVariables = {
      PAGER           = "less -R";
      EDITOR          = "nvim";
      VISUAL          = "nvim";
      TERM            = "xterm-256color";
      XDG_CONFIG_HOME = "${HOME}/.config";
      XDG_DATA_HOME   = "${HOME}/.local/share";
      XDG_DATA_DIRS   = "${HOME}/.local/data";
      XDG_RUNTIME_DIR = "${HOME}/.local/run";
    };

    stateVersion = "20.09";
  };

}
