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
    name = "nix"
    language-server = { command = "nil" }
    formatter = { command = "nixpkgs-fmt" }
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
      "bogster"
      "catppuccin_mocha"
      "emacs"
      "fleet_dark"
      "gruvbox"
      "gruvbox_light"
      "meliora"
      "noctis"
      "noctis_bordo"
      "onelight"
      "papercolor-light"
      "snazzy"
      "spacebones_light"
      "tokyonight"
      "varua"
    ];
  };

  home.packages = with pkgs; [
    nodePackages.vscode-langservers-extracted
    terraform-ls
  ];
}
