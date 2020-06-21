{ config, lib, pkgs, ... }:

let

  platform = import ../layers/posix-shell.nix { };

  shellAliases =
    platform.default.aliases // (
      if      pkgs.stdenv.isLinux  then platform.linux.aliases
      else if pkgs.stdenv.isDarwin then platform.darwin.aliases
      else { }
    );

  initExtra = ''
    ${platform.default.initExtra}
    ${
      if      pkgs.stdenv.isLinux  then platform.linux.initExtra
      else if pkgs.stdenv.isDarwin then platform.darwin.initExtra
      else { }
    }
  '';

in

{
  programs.bash = {
    enable       = true;
    shellAliases = shellAliases;
    initExtra    = initExtra;

    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
    historyIgnore  = [ "ls" "cd" "exit" ];
  };
}
