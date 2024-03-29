{ name ? "standard"
, variant ? "dark"
, font ? { monospace = "DejaVu"; }
, override ? { }
}:

let

  bat-themes = rec {
    standard.light = "GitHub";
    standard.dark = "OneHalfDark";
    standard.black = "ansi";
    high-contrast.light = standard.light;
    high-contrast.dark = standard.dark;
    gruvbox.light = "gruvbox-light";
    gruvbox.dark = "gruvbox-dark";
    gruvbox.black = gruvbox.dark;
    monalisa.dark = "base16";
    monalisa.black = monalisa.dark;
    nord.dark = "Nord";
  };

  vivid-themes = rec {
    standard.light = "one-light";
    standard.dark = "one-dark";
    standard.black = standard.dark;
    high-contrast.light = standard.light;
    high-contrast.dark = standard.dark;
    gruvbox.light = "gruvbox-light";
    gruvbox.dark = "gruvbox-dark";
    gruvbox.black = gruvbox.dark;
    monalisa.dark = "lava";
    monalisa.black = monalisa.dark;
    nord.dark = "nord";
  };

  helix-themes = rec {
    standard.light = "trans_spacebones_light";
    standard.dark = "trans_noctis";
    standard.black = "trans_catppuccin_mocha";
    high-contrast.light = standard.light;
    high-contrast.dark = "trans_github_dark_high_contrast";
    gruvbox.light = "trans_gruvbox_light";
    gruvbox.dark = "trans_gruvbox";
    gruvbox.black = gruvbox.dark;
    monalisa.dark = "base16_transparent";
    monalisa.black = monalisa.dark;
    nord.dark = "nord";
  };

  zellij-themes = rec {
    standard.light = "catppuccin-latte";
    standard.dark = "one-half-dark-custom";
    standard.black = "dracula-custom";
    high-contrast.light = standard.light;
    high-contrast.dark = "dracula-custom";
    gruvbox.light = "kanagawa";
    gruvbox.dark = "gruvbox-dark-medium";
    gruvbox.black = "gruvbox-dark-black";
    monalisa.dark = gruvbox.dark;
    monalisa.black = gruvbox.dark;
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

    # standard.black = "Classic Dark (base16)";
    standard.black = "astromouse (terminal.sexy)";
    # standard.black = standard.dark;
    # standard.black = "Chalk (dark) (terminal.sexy)";
    # standard.black = "Bitmute (terminal.sexy)";

    high-contrast.light = standard.light;
    high-contrast.dark = "Bitmute (terminal.sexy)";

    # gruvbox.light = "Gruvbox (Gogh)";
    gruvbox.light = "Gruvbox Light";
    # gruvbox.light = "Gruvbox light, hard (base16)";

    # gruvbox.dark = "Darktooth (base16)";
    # gruvbox.dark = "Gruvbox dark, pale (base16)";
    gruvbox.dark = "Gruvbox dark, medium (base16)";
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


  difftasticTheme = variant:
    let
      themeMap = {
        dark = "dark";
        black = "dark";
        light = "light";
      };
    in
      themeMap.${variant} or (
        throw ''
          Unsupported name-variant combination for difftastic theme: ${variant}
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

    helix = override.helix or (selectTheme "helix" helix-themes name variant);
    zellij = selectTheme "zellij" zellij-themes name variant;
    bat = selectTheme "bat" bat-themes name variant;
    vivid = selectTheme "vivid" vivid-themes name variant;
    wezterm = selectTheme "wezterm" wezterm-themes name variant;
    delta = bat;
    difftastic = difftasticTheme variant;
  };
}
