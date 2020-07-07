{ pkgs
, theme ? "standard"
, variant ? "dark"
, font ? "default"
, ...
}:

let

  fonts.default = { };

  fonts.menlo = {
    normal = {
      family = "Menlo";
      style  = "Regular";
    };
    bold = {
      family = "Menlo";
      style  = "Regular";
    };
    italic = {
      family = "Menlo";
      style  = "Italic";
    };
  };

  fonts.firaMono = {
    normal = {
      family = "Fira Mono";
      style  = "Normal";
    };
    bold = {
      family = "Fira Mono";
      style  = "Medium";
    };
    italic = {
      family = "Fira Mono";
      style  = "Italic";
    };
  };

  themes.standard.light = {
    primary = {
      background        = "0xFFFFFF";
      foreground        = "0x3c3836";
      bright_foreground = "0xA02020";     # Dark Red
    };

    cursor = {
      text   = "0xffffff";
      cursor = "0xFF9C9C";
    };

    normal = {
      black   = "0xfbf1c7";
      red     = "0xcc241d";
      green   = "0x98971a";
      yellow  = "0xd79921";
      blue    = "0x458588";
      magenta = "0xb16286";
      cyan    = "0x689d6a";
      white   = "0x7c6f64";
    };

    bright = {
      black   = "0x928374";
      red     = "0x9d0006";
      green   = "0x79740e";
      yellow  = "0xb57614";
      blue    = "0x076678";
      magenta = "0x8f3f71";
      cyan    = "0x427b58";
      white   = "0x3c3836";
    };

    indexed_colors = [];
  };

  themes.standard.dark = {
    primary = {
      background = "0x1A1A1A";
      # background: "0x282828"
      foreground = "0xFAEED9";          # Sepia
      # foreground: "0xD9DCDE"        # Traditional
      bright_foreground = "0xFF9C9C";
    };

    cursor = {
      text = "0x474646";
      cursor = "0xFF9C9C";
    };

    normal = {
      black   = "0x474646";
      red     = "0xDA7085";
      green   = "0x87BB7C";
      yellow  = "0xD5B875";
      blue    = "0x70ACE5";
      magenta = "0xA48ADD";
      cyan    = "0x69C5CE";
      white   = "0xBCBEC0";
    };

    bright = {
      black   = "0x6A6C6C";
      red     = "0xED8499";
      green   = "0x97D589";
      yellow  = "0xE9CB88";
      blue    = "0x87BFF5";
      magenta = "0xB9A0EF";
      cyan    = "0x7BDBE4";
      white   = "0xD0D2D3";
    };

    indexed_colors = [];

  };

  themes.standard.black = {
    primary = {
      background = "0x000000";
      foreground = "0xFAEED9";          # Sepia
      # foreground = "0xD9DCDE";        # Traditional
      bright_foreground = "0xFF9C9C";
    };

    cursor = {
      text   = "0x474646";
      cursor = "0xFF9C9C";
    };

    normal = {
      black   = "0x474646";
      red     = "0xDA7085";
      green   = "0x87BB7C";
      yellow  = "0xD5B875";
      blue    = "0x70ACE5";
      magenta = "0xA48ADD";
      cyan    = "0x69C5CE";
      white   = "0xBCBEC0";
    };

    bright = {
      black   = "0x6A6C6C";
      red     = "0xED8499";
      green   = "0x97D589";
      yellow  = "0xE9CB88";
      blue    = "0x87BFF5";
      magenta = "0xB9A0EF";
      cyan    = "0x7BDBE4";
      white   = "0xD0D2D3";
    };

    indexed_colors = [];
  };

  themes.gruvbox.light = {
    primary = {
      #background        = "0xFBF1C7";
      background        = "0xF9F5D7";
      foreground        = "0x3C3836";
      bright_foreground = "0xA02020";     # Dark Red
    };

    cursor = {
      text   = "0xFFFFFF";
      cursor = "0xFF9C9C";
    };

    normal = {
      black   = "0xFBF1C7";
      red     = "0xCC241D";
      green   = "0x98971A";
      yellow  = "0xD79921";
      blue    = "0x458588";
      magenta = "0xB16286";
      cyan    = "0x689D6A";
      white   = "0x7C6F64";
    };

    bright = {
      black   = "0x928374";
      red     = "0x9D0006";
      green   = "0x79740E";
      yellow  = "0xB57614";
      blue    = "0x076678";
      magenta = "0x8F3F71";
      cyan    = "0x427B58";
      white   = "0x3C3836";
    };

    indexed_colors = [];
  };

  themes.gruvbox.dark = {
    primary = {
      background        = "0x1A1A1A";
      foreground        = "0xEBDBB2";
      bright_foreground = "0xFF9C9C";
    };

    cursor = {
      text   = "0x474646";
      cursor = "0xFF9C9C";
    };

    normal = {
      black   = "0x282828";
      red     = "0xCC241D";
      green   = "0x98971A";
      yellow  = "0xD79921";
      blue    = "0x458588";
      magenta = "0xB16286";
      cyan    = "0x689D6A";
      white   = "0xA89984";
    };

    bright = {
      black   = "0x928374";
      red     = "0xFB4934";
      green   = "0xB8BB26";
      yellow  = "0xFABD2F";
      blue    = "0x83A598";
      magenta = "0xD3869B";
      cyan    = "0x8EC07C";
      white   = "0xEBDBB2";
    };

    indexed_colors = [];
  };

  themes.gruvbox.black = {
    primary = {
      background        = "0x000000";
      foreground        = "0xEBDBB2";
      bright_foreground = "0xFF9C9C";
    };

    cursor = {
      text   = "0x474646";
      cursor = "0xFF9C9C";
    };

    normal = {
      black   = "0x282828";
      red     = "0xCC241D";
      green   = "0x98971A";
      yellow  = "0xD79921";
      blue    = "0x458588";
      magenta = "0xB16286";
      cyan    = "0x689D6A";
      white   = "0xA89984";
    };

    bright = {
      black   = "0x928374";
      red     = "0xFB4934";
      green   = "0xB8BB26";
      yellow  = "0xFABD2F";
      blue    = "0x83A598";
      magenta = "0xD3869B";
      cyan    = "0x8EC07C";
      white   = "0xEBDBB2";
    };

    indexed_colors = [];
  };

in

{

  alacritty = {
    colors = themes.${theme}.${variant};
    font   = fonts.${font};
  };

  neovim = {
    colorScheme =
      if theme != "gruvbox" then "PaperColor"
      else "gruvbox";

    background =
      if variant == "light" then "light"
      else "dark";
  };

  bat.theme =
    if variant == "light" then "GitHub"
    else "TwoDark";

}
