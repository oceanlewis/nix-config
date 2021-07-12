{ pkgs, config, lib, ... }:
{
  home.services.lorri.enable = true;
  packages = [ pkgs.lorri pkgs.direnv ];
}
