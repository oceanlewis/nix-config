{ config, lib, pkgs, ... }:

let

  shell = import ../layers/posix-shell.nix { inherit pkgs; };

in

{

  packages = with pkgs; [ bashInteractive_5 ];

  program = {
    programs.bash = {
      enable       = true;
      shellAliases = shell.aliases;
      initExtra    = ''
        set -o vi
        ${shell.initExtra}
      '';

      historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
      historyIgnore  = [ "ls" "cd" "exit" ];
    };
  };

}
