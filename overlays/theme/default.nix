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

  helix-themes = rec {
    standard.light = "trans_spacebones_light";
    standard.dark = "trans_noctis";
    standard.black = standard.dark;
    gruvbox.light = "trans_gruvbox_light";
    gruvbox.dark = "trans_varua";
    gruvbox.black = gruvbox.dark;
    monalisa.dark = gruvbox.dark;
    monalisa.black = gruvbox.dark;
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

  wezterm-themes = rec {
    standard.light = "Humanoid light (base16)";
    # standard.light = "Mexico Light (base16)";
      # standard.light = "iA Light (base16)";
      # standard.light = "Heetch Light (base16)";

    standard.dark = "Invisibone (terminal.sexy)";
    # standard.dark = "laserwave (Gogh)";
    # standard.dark = "hund (terminal.sexy)";
    # standard.dark = "Chalk (base16)";
    # standard.dark = "Horizon Dark (base16)";
    # standard.dark = "Sequoia Moonlight";
    # standard.dark = "Erebus (terminal.sexy)";
    standard.black = standard.dark;

    # gruvbox.light = "Gruvbox (Gogh)";
    gruvbox.light = "Gruvbox Light";
    # gruvbox.light = "Gruvbox light, hard (base16)";

    # gruvbox.dark = "Darktooth (base16)";
    # gruvbox.dark = "Gruvbox dark, pale (base16)";
    gruvbox.dark = "Gruvbox Dark";
    gruvbox.black = "Gruvbox dark, hard (base16)";

    monalisa.dark = "IC_Orange_PPL";
    monalisa.black = monalisa.black;

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
    wezterm = selectTheme "wezterm" wezterm-themes name variant;
    delta = bat;
  };
}
