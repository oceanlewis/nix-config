{
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs)
    runCommandLocal
    zoxide
    nushell
    nufmt
    ;

  inherit (pkgs.nushellPlugins) polars;

  zoxideInit = runCommandLocal "zoxide-init-nushell" { buildInputs = [ zoxide ]; } ''
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
    package = nushell;
    configFile.text = config;
    plugins = [ polars ];
  };

  home.packages = [ nufmt ];
}
