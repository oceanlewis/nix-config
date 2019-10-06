{ config, lib, pkgs, ... }:

with lib;

let
  inherit (pkgs) stdenv;
  config = builtins.readFile ../config/git.conf;
in

{
  programs.git = {
    enable = true;
    userEmail = "david@weassemble.com";
    userName = "David Lewis";
    signing.key = "0x299C070BD065C19F";
    signing.signByDefault = true;
  };
}
