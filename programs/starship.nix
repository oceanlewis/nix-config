{ ... }: {

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;
      scan_timeout = 30;
      right_format = "$git_status$git_branch";

      git_branch = {
        symbol = "";
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };

      character = {
        success_symbol = "\n[ λ](bold purple)";
        error_symbol = "\n[ λ](bold red)";
        vicmd_symbol = "\n[ λ](bold blue)";
      };
      nix_shell.format = "[nix]($style)";
    };
  };

}
