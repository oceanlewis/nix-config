{ pkgs, config, lib, ... }:

let

  shell = import ../layers/posix-shell.nix { inherit pkgs; };

in

{
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

  packages = with pkgs; [ bashInteractive_5 ];
}
