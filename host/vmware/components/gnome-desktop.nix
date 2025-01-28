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

      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverrides = ''
          [org.gnome.desktop.interface]
          scaling-factor=2
        '';
      };

      displayManager.gdm = {
        enable = true;
        wayland = false;
      };
    };

    gnome.gnome-settings-daemon.enable = true;

    dbus.packages = [ pkgs.gnome3.dconf ];
    udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.dconf-editor
    gnomeExtensions.user-themes
    pantheon.elementary-gtk-theme
    pantheon.elementary-icon-theme
    pantheon.elementary-sound-theme
  ];
}
