{ config, pkgs, ... }:

{
  home.stateVersion = "20.09";

  home.username = "david";
  home.homeDirectory = "/home/david";
  home.packages = import ../layers/development-packages.nix {};
  # home.sessionVariables = {
  #   OPENSSL_LIB_DIR 
  # }

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
