{ pkgs, lib, ... }:
let

  makeTrans = themes:
    let
      inherit (lib) attrsets;
      inherit (attrsets) genAttrs mapAttrs' nameValuePair;

      t = genAttrs themes (theme:
        { inherits = theme; "ui.background" = { }; }
      );
    in
    mapAttrs'
      (name: value:
        nameValuePair "trans_${name}" value
      )
      t;

in
{

  nixpkgs.config.allowUnfree = true;

  xdg.configFile."helix/languages.toml".text = ''
    [[language]]
    name = "sql"
    formatter = { command = "sleek", args = ["--indent-spaces=2"] }

    [language-server.nextls]
    command = "nextls"
    args = ["--stdio=true"]  

    [language-server.nushell]
    command = "nu"
    args = ["--lsp"]

    [[language]]
    name = "nix"
    language-servers = ["nil"]
    formatter = { command = "nixpkgs-fmt" }

    [[language]]
    name = "java"
    language-servers = ["jdtls"]

    [[language]]
    name = "nu"
    language-servers = ["nushell"]

    [[language]]
    name = "elixir"
    indent = { tab-width = 2, unit = "  " }

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
      };

      keys.normal = {
        "A-l" = "goto_next_buffer";
        "A-h" = "goto_previous_buffer";
        "A-backspace" = ":buffer-close";
        "A-w" = ":buffer-close";
        "A-f" = ":format";
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
    terraform-ls
    marksman

    # SQL formatter
    sleek
  ];
}
