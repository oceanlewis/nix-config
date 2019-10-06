{ config, lib, pkgs, ... }:

with lib;

let
  inherit (pkgs) stdenv;
  alacrittyConfig = builtins.readFile ./alacritty.yml;
in

{
  alacritty = {
    enable = true;
    tmuxConfig = tmuxConfig + ''
      colors: *gruvbox_super_dark
      '';
  };
}