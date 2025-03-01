{
  pkgs,
  lib,
  ...
}:
let
  makeTrans =
    themes:
    let
      inherit (lib) attrsets;
      inherit (attrsets) genAttrs mapAttrs' nameValuePair;

      t = genAttrs themes (theme: {
        inherits = theme;
        "ui.background" = { };
      });
    in
    mapAttrs' (name: value: nameValuePair "trans_${name}" value) t;
in
{
  xdg.configFile."helix/languages.toml".text = ''
    [[language]]
    name = "sql"
    formatter = { command = "sleek", args = ["--indent-spaces=2"] }

    [language-server.nextls]
    command = "nextls"
    args = ["--stdio=true"]

    [language-server.nixd]
    command = "nixd"

    [language-server.nushell]
    command = "nu"
    args = ["--lsp"]

    [[language]]
    name = "nix"
    language-servers = ["nixd"]
    formatter = { command = "nixfmt" }

    [[language]]
    name = "elixir"
    indent = { tab-width = 2, unit = "  " }

    [[language]]
    name = "java"
    language-servers = ["jdtls"]

    [[language]]
    name = "nu"
    language-servers = ["nushell"]

    ## NextLS seems to not work in VSCode or Helix for me :(
    # [[language]]
    # name = "elixir"
    # scope = "source.elixir"
    # language-servers = ["nextls"]
  '';

  programs.helix = {
    enable = true;

    settings = {
      theme = pkgs.theme.helix;

      editor = {
        line-number = "relative";
        soft-wrap.enable = true;
        bufferline = "multiple";

        # Minimum severity to show a diagnostic after the end of a line:
        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          # Minimum severity to show a diagnostic on the primary cursor's line.
          # Note that `cursor-line` diagnostics are hidden in insert mode.
          cursor-line = "error";
          # Minimum severity to show a diagnostic on other lines:
          other-lines = "error";
        };
      };

      keys.normal = {
        "A-l" = "goto_next_buffer";
        "A-h" = "goto_previous_buffer";
        "A-backspace" = ":buffer-close";
        "A-w" = ":buffer-close";

        space = {
          "=" = ":format";
          "f" = "file_picker_in_current_directory";
          "F" = "file_picker";
        };
      };
    };
    themes = makeTrans [
      "acme"
      "ayu_dark"
      "ayu_evolve"
      "base16_default"
      "base16_default_dark"
      "bogster"
      "bogster_light"
      "catppuccin_mocha"
      "catppuccin_latte"
      "curzon"
      "cyan_light"
      "dracula"
      "dracula_at_night"
      "emacs"
      "ferra"
      "flatwhite"
      "fleet_dark"
      "github_dark_high_contrast"
      "github_light"
      "github_light_high_contrast"
      "gruvbox"
      "gruvbox_light"
      "kaolin-dark"
      "kaolin-light"
      "kaolin-valley-dark"
      "meliora"
      "noctis"
      "noctis_bordo"
      "modus_operandi_tinted"
      "modus_vivendi_tinted"
      "onelight"
      "papercolor-dark"
      "papercolor-light"
      "pop-dark"
      "snazzy"
      "sonokai"
      "spacebones_light"
      "tokyonight"
      "varua"
      "zed_onedark"
      "zed_onelight"
    ];
  };

  home.packages = with pkgs; [
    nodePackages.vscode-langservers-extracted
    typescript-language-server
    docker-compose-language-service
    terraform-ls
    marksman
    nixd
    alejandra
    nixfmt-rfc-style

    # SQL formatter
    sleek
  ];
}
