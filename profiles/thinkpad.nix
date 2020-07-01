{ config, pkgs, ... }:

let

  USER = "david";
  HOME = "/home/${USER}";

in

{

  home = {
    username      = USER;
    homeDirectory = HOME;
    packages      = import ../layers/development-packages.nix {} ++ [ pkgs.ion ];

    sessionVariables = {
      PAGER  = "less -R";
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERM   = "xterm-256color";
    };

    stateVersion = "20.09";
  };

  programs.home-manager.enable = true;

  imports = [
    ../programs/git/git.nix
    ../programs/bash.nix
    ../programs/zsh.nix
    ../programs/tmux.nix
    ../programs/neovim.nix
    ../programs/starship.nix
  ];

}
