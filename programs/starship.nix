{ pkgs
, config
, lib
, extraConfig ? { }
, ...
}: {
  home.programs.starship = {
    enable                = true;
    enableBashIntegration = true;
    enableZshIntegration  = true;

    settings = lib.recursiveUpdate {
      add_newline       = true;
      scan_timeout      = 30;
      character.symbol  = "➜";
      git_branch.symbol = "";
    } extraConfig;
  };
}
