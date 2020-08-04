{ pkgs, config, lib, ... }:

let

  theme = import ../layers/theme.nix {
    inherit pkgs;

    theme      = "gruvbox";
    variant    = "light";
    fontFamily = "Fira Mono";
    fontSize   = 13;
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
    extraPlugins = (
      dhall.vimPlugins ++
      ruby.vimPlugins ++
      rust.vimPlugins
    );
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

in

{

  programs = {
    home-manager.enable = true;
    man.enable = false;
  };

  imports = [
    git.home
    bash.home
    alacritty.home
    neovim.home
    zsh.home
    tmux.home
    starship.home
    lorri.home
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
      neovim.packages ++
      dhall.packages ++
      bash.packages ++
      lorri.packages ++ [
        pkgs.ion
        pkgs.neuron-notes
      ];

    extraOutputsToInstall = [ "man" ];
    sessionVariables = {
      PAGER     = "less -R";
      EDITOR    = "nvim";
      VISUAL    = "nvim";
      TERM      = "xterm-256color";
    };

    stateVersion = "20.09";
  };

}
