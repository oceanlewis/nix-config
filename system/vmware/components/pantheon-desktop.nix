{ config, lib, pkgs, modulesPath, ... }:

{
  services = {
    xserver = {
      enable = true;
      desktopManager.pantheon = {
        enable = true;
        debug = true;
      };
    };

    pantheon = {
      apps.enable = true;
      contractor.enable = true;
    };
  };

  programs.pantheon-tweaks.enable = true;
}
