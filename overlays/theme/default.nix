let
  name = "gruvbox";
  variant = "light";
  font.monospace = "DejaVu";

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

in
self: super: {
  theme = rec {
    inherit
      name variant font;

    bat.theme = selectTheme "bat" bat-themes "${name}-${variant}";
    vivid.theme = selectTheme "vivid" vivid-themes "${name}-${variant}";
    delta = bat.theme;
  };
}
