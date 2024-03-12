{ pkgs, lib, ... }:
let
  zoxideInit =
    pkgs.runCommand "zoxide-init-nushell"
      { buildInputs = with pkgs; [ zoxide nushell ]; }
      ''
        mkdir $out
        zoxide init nushell > $out/init.nu
      '';

  config = lib.concatLines [
    (builtins.readFile ./config.nu)
    "source ${zoxideInit}/init.nu"
  ];
in
{
  programs.nushell = {
    enable = true;
    package = pkgs.nushellFull;
    configFile.text = config;
  };
}
