{ pkgs, lib, ... }:
let

  defaultLayout = builtins.replaceStrings
    [ "$PLUGIN_LOCATION" ]
    [ "file:${pkgs.zjstatus}/bin/zjstatus.wasm" ]
    (builtins.readFile ./zjstatus_layout.kdl);

  configContents = lib.concatLines (
    (lib.lists.optional pkgs.stdenv.isDarwin ''copy_command "pbcopy"'')
    ++ [
      ''theme "${pkgs.theme.zellij}"''
      (builtins.readFile ./config.kdl)
    ]
  );
in
{
  home.packages = [ pkgs.zjstatus ];
  xdg.configFile."zellij/layouts/default.kdl".text = defaultLayout;
  xdg.configFile."zellij/config.kdl".text = configContents;
  programs.zellij.enable = true;
}
