{ ... }:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    settings = {
      add_newline = true;
      scan_timeout = 30;

      git_branch.disabled = false;
      git_status.disabled = true;
      nix_shell.format = "[nix]($style) ";
      aws.format = "on [(\($region\) )]($style)";

      character = {
        success_symbol = "\n[ λ](bold purple)";
        error_symbol = "\n[ λ](bold red)";
        vicmd_symbol = "\n[ λ](bold blue)";
      };
    };
  };
}
