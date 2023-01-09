{ name ? "standard"
, variant ? "dark"
, font ? { monospace = "DejaVu"; }
, ...
}:

let
  bat-themes =
    {
      "standard-light" = "GitHub";
      "standard-dark" = "OneHalfDark";
      "standard-black" = "OneHalfDark";
      "gruvbox-light" = "gruvbox-light";
      "gruvbox-dark" = "gruvbox-dark";
      "gruvbox-black" = "gruvbox-dark";
      "monalisa-dark" = "gruvbox-dark";
      "monalisa-black" = "gruvbox-dark";
      "nord-dark" = "Nord";
    };

  vivid-themes =
    {
      "standard-light" = "one-light";
      "standard-dark" = "one-dark";
      "standard-black" = "one-dark";
      "gruvbox-light" = "gruvbox-light";
      "gruvbox-dark" = "gruvbox-dark";
      "gruvbox-black" = "gruvbox-dark";
      "monalisa-dark" = "lava";
      "monalisa-black" = "lava";
      "nord-dark" = "nord";
    };

  helix-themes = {
    "standard-light" = "emacs";
    "standard-dark" = "night_owl";
    "standard-black" = "base16_transparent";
    "gruvbox-light" = "gruvbox_light";
    "gruvbox-dark" = "gruvbox";
    "gruvbox-black" = "autumn_night";
    "monalisa-dark" = "base16_terminal";
    "monalisa-black" = "base16_terminal";
    "nord-dark" = "nord";
  };

  zellij-themes = {
    "standard-light" = "onelight";
    "standard-dark" = "snazzy";
    "standard-black" = "snazzy";
    "gruvbox-light" = "gruvbox-light";
    "gruvbox-dark" = "gruvbox-dark";
    "gruvbox-black" = "gruvbox-dark";
    "monalisa-dark" = "gruvbox-dark";
    "monalisa-black" = "gruvbox-dark";
    "nord-dark" = "nord";
  };

  selectTheme = programName: themeMap: themeName:
    themeMap.${themeName} or (
      throw ''
        Unsupported name-variant combination for ${programName} theme: ${themeName}
        Supported combinations:
        ${
          builtins.concatStringsSep "\n" (
            builtins.map (attrName: "  - ${attrName}")
              (builtins.attrNames themeMap)
          )
        }
      ''
    );

  nv = "${name}-${variant}";

in
self: super: {
  theme = rec {
    inherit
      name variant font;

    helix = selectTheme "helix" helix-themes nv;
    zellij = selectTheme "zellij" zellij-themes nv;
    bat = selectTheme "bat" bat-themes nv;
    vivid = selectTheme "vivid" vivid-themes nv;
    delta = bat;
  };
}
