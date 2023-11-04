{ config, lib, pkgs, modulesPath, ... }:

{
  services.udev.extraRules = ''
    # STM32F3DISCOVERY - ST-LINK/V2.1
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE:="0666"
  '';
}
