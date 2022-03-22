let
  name = "gruvbox";
  variant = "dark";
  font.monospace = "DejaVu";

  bat-themes =
    {
      "standard-light" = "Coldark-Cold";
      "standard-dark" = "OneHalfDark";
      "standard-black" = "OneHalfDark";
      "gruvbox-light" = "gruvbox-light";
      "gruvbox-dark" = "gruvbox-dark";
      "gruvbox-black" = "gruvbox-dark";
      "monalisa-dark" = "gruvbox-dark";
      "monalisa-black" = "gruvbox-dark";
    };

  selectBatTheme = name: variant:
    bat-themes."${name}-${variant}" or (
      throw ''
        Unsupported name-variant combination for bat theme: ${name}-${variant}
        Supported combinations:
        ${
          builtins.concatStringsSep "\n" (
            builtins.map (attrName: "  - ${attrName}")
              (builtins.attrNames bat-themes)
          )
        }
      ''
    );

in
self: super: {
  theme = rec {
    inherit
      name variant font;

    bat.theme = selectBatTheme name variant;
    delta = bat.theme;
  };
}
