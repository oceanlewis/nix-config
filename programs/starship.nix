{ pkgs, config, lib, ... }:

{
  home.programs.starship = {
    enable                = true;
    enableBashIntegration = true;
    enableZshIntegration  = true;

    settings = {
      add_newline       = true;
      scan_timeout      = 30;
      character.symbol  = "➜";
      git_branch.symbol = "";
    };
  };
}
