{ config }:

let
  settings = {
    name = "standard";
    variant = "dark";
    font.monospace = "DejaVu";
  } // config;

  inherit (settings) name variant font;

  bat-themes =
    {
      standard.light = "GitHub";
      standard.dark = "OneHalfDark";
      standard.black = "OneHalfDark";
      gruvbox.light = "gruvbox-light";
      gruvbox.dark = "gruvbox-dark";
      gruvbox.black = "gruvbox-dark";
      monalisa.dark = "gruvbox-dark";
      monalisa.black = "gruvbox-dark";
      nord.dark = "Nord";
    };

  vivid-themes =
    {
      standard.light = "one-light";
      standard.dark = "one-dark";
      standard.black = "one-dark";
      gruvbox.light = "gruvbox-light";
      gruvbox.dark = "gruvbox-dark";
      gruvbox.black = "gruvbox-dark";
      monalisa.dark = "lava";
      monalisa.black = "lava";
      nord.dark = "nord";
    };

  helix-themes = {
    standard.light = "trans_spacebones_light";
    standard.dark = "trans_fleet_dark";
    standard.black = "trans_fleet_dark";
    gruvbox.light = "trans_gruvbox_light";
    gruvbox.dark = "trans_varua";
    gruvbox.black = "trans_varua";
    monalisa.dark = "trans_varua";
    monalisa.black = "trans_varua";
    nord.dark = "nord";
  };

  zellij-themes = {
    standard.light = "onelight";
    standard.dark = "snazzy";
    standard.black = "snazzy";
    gruvbox.light = "gruvbox-light";
    gruvbox.dark = "gruvbox-dark";
    gruvbox.black = "gruvbox-dark";
    monalisa.dark = "gruvbox-dark";
    monalisa.black = "gruvbox-dark";
    nord.dark = "nord";
  };

  selectTheme = programName: themeMap: name: variant:
    themeMap.${name}.${variant} or (
      throw ''
        Unsupported name-variant combination for ${programName} theme: ${name}.${variant}
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

    helix = settings.helix or (selectTheme "helix" helix-themes name variant);
    zellij = selectTheme "zellij" zellij-themes name variant;
    bat = selectTheme "bat" bat-themes name variant;
    vivid = selectTheme "vivid" vivid-themes name variant;
    delta = bat;
  };
}
