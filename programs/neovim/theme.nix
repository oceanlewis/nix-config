{ pkgs }:

let
  inherit (pkgs) theme;
  inherit (theme) name variant;
  scheme_name = "${name}-${variant}";

  color_scheme = {
    "standard-light" = "rdark-terminal2";
    "standard-dark" = "rdark-terminal2";
    "standard-black" = "rdark-terminal2";
    "gruvbox-light" = "gruvbox8";
    "gruvbox-dark" = "gruvbox8";
    "gruvbox-black" = "gruvbox8";
    "monalisa-dark" = "gruvbox8";
    "monalisa-black" = "gruvbox8";
  }.${scheme_name}
    or (throw "Unsupported theme-variant combination for neovim: ${scheme_name}");

  background =
    if variant == "light" then "light"
    else "dark";

in
{ inherit color_scheme background; }
