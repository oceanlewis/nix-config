{ pkgs, ... }:
let
  zoxideInit =
    pkgs.runCommand "zoxide-init-nushell"
      { buildInputs = [ pkgs.zoxide ]; }
      ''
        mkdir $out
        zoxide init nushell > $out/init.nu
      '';

  config = ''
    ${builtins.readFile ./config.nu}     
    source ${zoxideInit}/init.nu
  '';
in
{
  programs.nushell = {
    enable = true;
    package = pkgs.nushellFull;
    configFile.text = config;
  };
}
