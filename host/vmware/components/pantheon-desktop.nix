{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  services = {
    xserver = {
      enable = true;
      desktopManager.pantheon = {
        enable = true;
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
