{ pkgs }:

let
  inherit (pkgs.theme) name variant;

  color_scheme = rec {
    standard.light = "PaperColor"; #"flattened_light";
    standard.dark = "challenger_deep";
    standard.black = standard.dark;
    high-contrast.light = standard.light;
    high-contrast.dark = standard.dark;
    gruvbox.light = "gruvbox8";
    gruvbox.dark = "gruvbox8";
    gruvbox.black = gruvbox.dark;
    monalisa.dark = gruvbox.dark;
    monalisa.black = gruvbox.dark;
    nord.dark = "nord";
  }.${name}.${variant}
    or (throw "Unsupported theme-variant combination for neovim: ${name}.${variant}");

  background =
    if variant == "light" then "light"
    else "dark";

in
{ inherit color_scheme background; }
