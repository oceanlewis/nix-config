{ pkgs }:

let
  inherit (pkgs) theme;

  themes.standard.light = {
    primary = {
      background = "0xFFFFFF";
      foreground = "0x3c3836";
      bright_foreground = "0xA02020"; # Dark Red
    };

    cursor = {
      text = "0xffffff";
      cursor = "0xFF9C9C";
    };

    normal = {
      black = "0xfbf1c7";
      red = "0xcc241d";
      green = "0x98971a";
      yellow = "0xd79921";
      blue = "0x458588";
      magenta = "0xb16286";
      cyan = "0x689d6a";
      white = "0x7c6f64";
    };

    bright = {
      black = "0x928374";
      red = "0x9d0006";
      green = "0x79740e";
      yellow = "0xb57614";
      blue = "0x076678";
      magenta = "0x8f3f71";
      cyan = "0x427b58";
      white = "0x3c3836";
    };

    indexed_colors = [ ];
  };

  themes.standard.dark = {
    primary = {
      background = "0x272727";
      foreground = "0xF1F1F1"; # Traditional
      bright_foreground = "0xFF9C9C";
    };

    cursor = {
      text = "0x474646";
      cursor = "0xFF9C9C";
    };

    normal = {
      black = "0x474646";
      red = "0xDA7085";
      green = "0x87BB7C";
      yellow = "0xD5B875";
      blue = "0x70ACE5";
      magenta = "0xA48ADD";
      cyan = "0x69C5CE";
      white = "0xBCBEC0";
    };

    bright = {
      black = "0x6A6C6C";
      red = "0xED8499";
      green = "0x97D589";
      yellow = "0xE9CB88";
      blue = "0x87BFF5";
      magenta = "0xB9A0EF";
      cyan = "0x7BDBE4";
      white = "0xD0D2D3";
    };

    indexed_colors = [ ];

  };

  themes.standard.black = {
    primary = {
      background = "0x1A1A1A";
      foreground = "0xFAEED9"; # Sepia
      bright_foreground = "0xFF9C9C";
    };

    cursor = {
      text = "0x474646";
      cursor = "0xFF9C9C";
    };

    normal = {
      black = "0x474646";
      red = "0xDA7085";
      green = "0x87BB7C";
      yellow = "0xD5B875";
      blue = "0x70ACE5";
      magenta = "0xA48ADD";
      cyan = "0x69C5CE";
      white = "0xBCBEC0";
    };

    bright = {
      black = "0x6A6C6C";
      red = "0xED8499";
      green = "0x97D589";
      yellow = "0xE9CB88";
      blue = "0x87BFF5";
      magenta = "0xB9A0EF";
      cyan = "0x7BDBE4";
      white = "0xD0D2D3";
    };

    indexed_colors = [ ];
  };

  themes.gruvbox.light = {
    primary = {
      background = "0xF9F5D7";
      foreground = "0x3C3836";
      bright_foreground = "0xA02020"; # Dark Red
    };

    cursor = {
      text = "0xFFFFFF";
      cursor = "0xFF9C9C";
    };

    normal = {
      black = "0xFBF1C7";
      red = "0xCC241D";
      green = "0x98971A";
      yellow = "0xD79921";
      blue = "0x458588";
      magenta = "0xB16286";
      cyan = "0x689D6A";
      white = "0x7C6F64";
    };

    bright = {
      black = "0x928374";
      red = "0x9D0006";
      green = "0x79740E";
      yellow = "0xB57614";
      blue = "0x076678";
      magenta = "0x8F3F71";
      cyan = "0x427B58";
      white = "0x3C3836";
    };

    indexed_colors = [ ];
  };

  themes.gruvbox.dark = {
    primary = {
      background = "0x292828";
      foreground = "0xEBDBB2";
      bright_foreground = "0xFF9C9C";
    };

    cursor = {
      text = "0x474646";
      cursor = "0xFF9C9C";
    };

    normal = {
      black = "0x282828";
      red = "0xCC241D";
      green = "0x98971A";
      yellow = "0xD79921";
      blue = "0x458588";
      magenta = "0xB16286";
      cyan = "0x689D6A";
      white = "0xA89984";
    };

    bright = {
      black = "0x928374";
      red = "0xFB4934";
      green = "0xB8BB26";
      yellow = "0xFABD2F";
      blue = "0x83A598";
      magenta = "0xD3869B";
      cyan = "0x8EC07C";
      white = "0xEBDBB2";
    };

    indexed_colors = [ ];
  };

  themes.gruvbox.black = {
    primary = {
      background = "0x1A1A1A";
      foreground = "0xEBDBB2";
      bright_foreground = "0xFF9C9C";
    };

    cursor = {
      text = "0x474646";
      cursor = "0xFF9C9C";
    };

    normal = {
      black = "0x282828";
      red = "0xCC241D";
      green = "0x98971A";
      yellow = "0xD79921";
      blue = "0x458588";
      magenta = "0xB16286";
      cyan = "0x689D6A";
      white = "0xA89984";
    };

    bright = {
      black = "0x928374";
      red = "0xFB4934";
      green = "0xB8BB26";
      yellow = "0xFABD2F";
      blue = "0x83A598";
      magenta = "0xD3869B";
      cyan = "0x8EC07C";
      white = "0xEBDBB2";
    };

    indexed_colors = [ ];
  };

  themes.monalisa.dark = {
    primary = {
      background = "0x160B0E";
      foreground = "0xF9DB7C";
      bright_foreground = "0xFF9C9C";
    };

    cursor = {
      text = "0x160B0E";
      cursor = "0xCF7F40";
    };

    normal = {
      black = "0x44230F";
      red = "0xAC3A24";
      green = "0x767340";
      yellow = "0xCE8134";
      blue = "0x646E6F";
      magenta = "0xAD2E36";
      cyan = "0x6A9068";
      white = "0xF9DC6E";
    };

    bright = {
      black = "0x9A5534";
      red = "0xFF5B3E";
      green = "0xC0BD76";
      yellow = "0xFFA678";
      blue = "0xADBFC1";
      magenta = "0xFF747C";
      cyan = "0x99D3A0";
      white = "0xFFE8A7";
    };

    indexed_colors = [ ];
  };
  themes.monalisa.black = themes.monalisa.dark;

  themes.snazzy.dark = {
    primary = {
      background = "#282A36";
      foreground = "#EFF0EB";
      bright_foreground = "#9AEDFE";
    };

    cursor = {
      cursor = "#97979B";
    };

    selection = {
      text = "#282A36";
      background = "#FEFFFF";
    };

    normal = {
      black = "#282A36";
      red = "#FF5C57";
      green = "#5AF78E";
      yellow = "#F3F99D";
      blue = "#57C7FF";
      magenta = "#FF6AC1";
      cyan = "#9AEDFE";
      white = "#F1F1F0";
    };

    bright = {
      black = "#686868";
      red = "#FF5C57";
      green = "#5AF78E";
      yellow = "#F3F99D";
      blue = "#57C7FF";
      magenta = "#FF6AC1";
      cyan = "#9AEDFE";
      white = "#EFF0EB";
    };
  };

  themes.nord.dark = {
    primary = {
      background = "0x2E3440";
      foreground = "0xD8DEE9";
      bright_foreground = "#9AEDFE";
    };

    cursor = {
      text = "0x2E3440";
      cursor = "0xD8DEE9";
    };

    normal = {
      black = "0x3B4252";
      red = "0xBF616A";
      green = "0xA3BE8C";
      yellow = "0xEBCB8B";
      blue = "0x81A1C1";
      magenta = "0xB48EAD";
      cyan = "0x88C0D0";
      white = "0xE5E9F0";
    };

    bright = {
      black = "0x4C566A";
      red = "0xBF616A";
      green = "0xA3BE8C";
      yellow = "0xEBCB8B";
      blue = "0x81A1C1";
      magenta = "0xB48EAD";
      cyan = "0x8FBCBB";
      white = "0xECEFF4";
    };
  };

in
themes.${theme.name}.${theme.variant}
