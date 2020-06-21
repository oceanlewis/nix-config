{ config, pkgs, ... }:

{

  home = {
    username      = "davidlewis";
    homeDirectory = "/Users/davidlewis";
    packages      = import ../layers/development-packages.nix { };

    sessionVariables = {
      PAGER  = "less -R";
      EDITOR = "nvim";
    };

    stateVersion = "20.09";
  };

  programs.home-manager.enable = true;

  imports = [
    ../programs/bash.nix
    ../programs/tmux.nix
    ../programs/neovim.nix
    ../programs/starship.nix
  ];

}
