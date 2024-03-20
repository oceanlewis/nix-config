{ pkgs, lib, ... }:
let
  inherit (pkgs) theme;

  modeBackground = {
    light = "#F8F8F3";
    dark = "#000000";
    black = "#000000";
  }.${theme.variant};

  defaultLayout = builtins.replaceStrings
    [
      "$PLUGIN_LOCATION"
      "$MODE_BG"
    ]
    [
      "file:${pkgs.zjstatus}/bin/zjstatus.wasm"
      modeBackground
    ]
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
