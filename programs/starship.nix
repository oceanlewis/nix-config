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
      git_branch.symbol = "";
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
        vicmd_symbol = "[➜](bold blue)";
      };
    } extraConfig;
  };

}
