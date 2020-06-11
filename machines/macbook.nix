{ config, pkgs, ... }:

{

  home = {
    username      = "davidlewis";
    homeDirectory = "/Users/davidlewis";
    packages      = import ../layers/development-packages.nix {};
    stateVersion  = "20.09";
  };

  programs = {
    home-manager.enable = true;
  
    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
  
      # plugins = with pkgs.vimPlugins; [];
    };
  };

}
