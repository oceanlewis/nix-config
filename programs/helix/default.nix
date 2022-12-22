{ pkgs, config, lib, ... }:
{
  programs.helix = {
    enable = true;

    settings = {
      theme = pkgs.theme.helix;

      editor = {
        line-number = "relative";
      };

      keys.normal = {
        "A-l" = "goto_next_buffer";
        "A-h" = "goto_previous_buffer";
        "A-backspace" = ":buffer-close";
        "A-f" = ":format";
      };
    };

    languages = [
      {
        name = "nix";
        language-server.command = "rnix-lsp";
      }
    ];
  };
}
