{ config, pkgs, ... }:

{

  home = {
    username      = "david";
    homeDirectory = "/home/david";
    packages      = import ../layers/development-packages.nix {} ++ [ pkgs.ion ];

    sessionVariables = {
      PAGER  = "less -R";
      EDITOR = "nvim";
    };

    stateVersion = "20.09";
  };

  programs.home-manager.enable = true;

  imports = [
    ../programs/bash.nix
    ../programs/zsh.nix
    ../programs/tmux.nix
    ../programs/neovim.nix
    ../programs/starship.nix
  ];

}
