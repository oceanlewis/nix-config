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
      "base16_default"
      "bogster"
      "catppuccin_mocha"
      "cyan_light"
      "dracula_at_night"
      "emacs"
      "flatwhite"
      "fleet_dark"
      "github_dark_high_contrast"
      "github_light"
      "github_light_high_contrast"
      "gruvbox"
      "gruvbox_light"
      "meliora"
      "noctis"
      "noctis_bordo"
      "onelight"
      "papercolor-dark"
      "papercolor-light"
      "penumbra"
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
  ];
}
