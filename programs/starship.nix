{ config, lib, pkgs, ... }:

{
  programs.starship = {
    enable                = true;
    enableBashIntegration = true;

    settings = {
      add_newline       = false;
      scan_timeout      = 30;
      character.symbol  = "➜";
      git_branch.symbol = "";
    };
  };
}
