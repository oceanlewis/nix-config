{ ... }: {

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;
      scan_timeout = 30;
      git_branch.symbol = "";

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
        vicmd_symbol = "[➜](bold blue)";
      };

      nix_shell.format = ''via [$symbol$state]($style) '';
    };
  };

}
