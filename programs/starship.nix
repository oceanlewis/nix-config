{ ... }: {

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;
      scan_timeout = 30;

      git_branch.symbol = "";
      nix_shell.format = "[nix]($style)";

      character = {
        success_symbol = "\n[ λ](bold purple)";
        error_symbol = "\n[ λ](bold red)";
        vicmd_symbol = "\n[ λ](bold blue)";
      };
    };
  };

}
