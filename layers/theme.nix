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
      background        = "0xfbf1c7";
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

  themes.gruvbox.dark = {
    primary = {
      background        = "0x1A1A1A";
      foreground        = "0xebdbb2";
      bright_foreground = "0xFF9C9C";
    };

    cursor = {
      text   = "0x474646";
      cursor = "0xFF9C9C";
    };

    normal = {
      black   = "0x282828";
      red     = "0xcc241d";
      green   = "0x98971a";
      yellow  = "0xd79921";
      blue    = "0x458588";
      magenta = "0xb16286";
      cyan    = "0x689d6a";
      white   = "0xa89984";
    };

    bright = {
      black   = "0x928374";
      red     = "0xfb4934";
      green   = "0xb8bb26";
      yellow  = "0xfabd2f";
      blue    = "0x83a598";
      magenta = "0xd3869b";
      cyan    = "0x8ec07c";
      white   = "0xebdbb2";
    };

    indexed_colors = [];
  };

  themes.gruvbox.black = {
    primary = {
      background        = "0x000000";
      foreground        = "0xebdbb2";
      bright_foreground = "0xFF9C9C";
    };

    cursor = {
      text   = "0x474646";
      cursor = "0xFF9C9C";
    };

    normal = {
      black   = "0x282828";
      red     = "0xcc241d";
      green   = "0x98971a";
      yellow  = "0xd79921";
      blue    = "0x458588";
      magenta = "0xb16286";
      cyan    = "0x689d6a";
      white   = "0xa89984";
    };

    bright = {
      black   = "0x928374";
      red     = "0xfb4934";
      green   = "0xb8bb26";
      yellow  = "0xfabd2f";
      blue    = "0x83a598";
      magenta = "0xd3869b";
      cyan    = "0x8ec07c";
      white   = "0xebdbb2";
    };

    indexed_colors = [];
  };

in

{

  alacritty.colors =
    if pkgs.stdenv.isDarwin then themes.${theme}.${variant} else
    if pkgs.stdenv.isLinux  then { /* TODO! */ }
    else { };

  alacritty.font =
    if pkgs.stdenv.isDarwin then fonts.${font} else
    if pkgs.stdenv.isLinux  then { /* TODO! */ }
    else { };

  neovim.colorScheme =
    if theme != "gruvbox" then "PaperColor"
    else                       "gruvbox";

  bat.theme =
    if variant == "light" then "GitHub"
    else                       "Dracula";

}
