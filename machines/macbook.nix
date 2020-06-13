{ config, pkgs, ... }:

{

  home = {
    username      = "davidlewis";
    homeDirectory = "/Users/davidlewis";
    packages      = import ../layers/development-packages.nix {};
    stateVersion  = "20.09";
  };

  programs.home-manager.enable = true;

  imports = [
    ../programs/tmux.nix
    ../programs/neovim.nix
  ];

}
