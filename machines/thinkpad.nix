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
