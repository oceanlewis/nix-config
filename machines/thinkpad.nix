{ config, pkgs, ... }:

{

  home = {
    stateVersion  = "20.09";
    username      = "david";
    homeDirectory = "/home/david";
    packages      = import ../layers/development-packages.nix {} ++ [ pkgs.ion ];

    sessionVariables = {
      PAGER  = "less -R";
      EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;

  imports = [
    ../programs/tmux.nix
    ../programs/neovim.nix
  ];

}
