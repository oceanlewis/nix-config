{ pkgs, ... }:
let
  zoxideInit =
    pkgs.runCommand "zoxide-init-nushell"
      { buildInputs = with pkgs; [ zoxide nushell ]; }
      ''
        mkdir $out

        zoxide init nushell \
        | nu --stdin -c '$in | str replace --all "def-env" "def --env"' \
        > $out/init.nu
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
