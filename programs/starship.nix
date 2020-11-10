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
        ## Supported by newer versions of `starship`
        # success_symbol = "[➜](bold green)";
        # error_symbol = "[➜](bold red)";
        # vicmd_symbol = "[➜](bold blue)";

        symbol = "➜";
        error_symbol = "✖";
        vicmd_symbol = "◐";
        use_symbol_for_status = true;
      };
    } extraConfig;
  };

}
