{ config, lib, pkgs, ... }:

{
  programs.starship = {
    enable                = true;
    enableBashIntegration = true;

    settings = {
      add_newline       = false;
      scan_timeout      = 30;
      character.symbol  = "\n➜";
      git_branch.symbol = "";
    };
  };
}
