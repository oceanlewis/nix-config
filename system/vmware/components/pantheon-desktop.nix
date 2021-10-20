{ config, lib, pkgs, modulesPath, ... }:

{
  services = {
    xserver = {
      enable = true;
      displayManager.lightdm.greeters.pantheon.enable = false;
      desktopManager.pantheon = {
        enable = true;
        debug = true;
        extraGSettingsOverrides = ''
          [org.gnome.desktop.interface]
          scaling-factor=2
        '';
      };
    };

    pantheon = {
      apps.enable = true;
      contractor.enable = true;
    };
  };

  programs.pantheon-tweaks.enable = true;
}
