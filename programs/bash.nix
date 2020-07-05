{ config, lib, pkgs, ... }:

let

  shell = import ../layers/posix-shell.nix { inherit pkgs; };

in

{

  packages = with pkgs; [ bashInteractive_5 ];

  home.programs.bash = {
    enable         = true;
    shellAliases   = shell.aliases;
    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
    historyIgnore  = [ "ls" "cd" "exit" ];

    initExtra    = ''
      set -o vi
      ${shell.initExtra}
    '';
  };

}
