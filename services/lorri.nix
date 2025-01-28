{
  pkgs,
  config,
  lib,
  ...
}:
{
  services.lorri.enable = true;
  home.packages = [
    pkgs.lorri
    pkgs.direnv
  ];
}
