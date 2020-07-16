{ pkgs, config, lib, ... }:

{

  home = {
    services.lorri = {
      enable = true;
    };
  };

  packages = with pkgs; [
    direnv
  ];

}
