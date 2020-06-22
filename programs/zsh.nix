{ config, lib, pkgs, ... }:

let

  shell = import ../layers/posix-shell.nix { inherit pkgs; };

in

{

  # Program Definition
  # - https://github.com/rycee/home-manager/blob/master/modules/programs/zsh.nix
  programs.zsh = {
    enable        = true;
    dotDir        = ".config/zsh";
    shellAliases  = shell.aliases;
    initExtra     = shell.initExtra;
    defaultKeymap = "viins";
  };

}
