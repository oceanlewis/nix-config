{ config, lib, pkgs, ... }:

let

  shell = import ../layers/posix-shell.nix { inherit pkgs; };

in

{

  programs.zsh = {
    enable       = true;
    dotDir       = ".config/zsh";
    shellAliases = shell.aliases;
    initExtra    = shell.initExtra;
  };

}
