{ pkgs }:

let
  inherit (pkgs) theme;

in
{
  default = { };

  "Menlo" = {
    normal = {
      family = "Menlo";
      style = "Bold";
    };
    bold = {
      family = "Menlo";
      style = "Bold";
    };
    italic = {
      family = "Menlo";
      style = "Bold";
    };
    offset = {
      x = 0;
      y = 0;
    };
    glyph_offset = {
      x = 0;
      y = 0;
    };
  };

  "DejaVuSansMono" = {
    normal = {
      family = "DejaVuSansMono Nerd Font";
      style = "Book";
    };
    bold = {
      family = "DejaVuSansMono Nerd Font";
      style = "Bold";
    };
    italic = {
      family = "DejaVuSansMono Nerd Font";
      style = "Oblique";
    };
    offset = {
      x = 2;
      y = 3;
    };
    glyph_offset = {
      x = 0;
      y = 0;
    };
  };

  "Mononoki" = {
    normal = {
      family = "Mononoki Nerd Font";
      style = "Regular";
    };
    bold = {
      family = "Mononoki Nerd Font";
      style = "Bold";
    };
    italic = {
      family = "Mononoki Nerd Font";
      style = "Italic";
    };
    offset = {
      x = 2;
      y = 2;
    };
    glyph_offset = {
      x = 0;
      y = 0;
    };
  };

  "SF Mono" = {
    normal = {
      family = "SF Mono";
      style = "Regular";
    };
    bold = {
      family = "SF Mono";
      style = "Semibold";
    };
    italic = {
      family = "SF Mono";
      style = "Light Italic";
    };
    offset = {
      x = 0;
      y = 3;
    };
    glyph_offset = {
      x = 0;
      y = 0;
    };
  };

  "Fira Mono" = {
    normal = {
      family = "Fira Mono";
      style = "Normal";
    };
    bold = {
      family = "Fira Mono";
      style = "Medium";
    };
    italic = {
      family = "Fira Mono";
      style = "Italic";
    };
    offset = {
      x = 0;
      y = 5;
    };
    glyph_offset = {
      x = 0;
      y = 0;
    };
  };

  "Fira Code" = {
    normal = {
      family = "FiraCode Nerd Font Mono";
      style = "Retina";
    };
    bold = {
      family = "FiraCode Nerd Font Mono";
      style = "SemiBold";
    };
    italic = {
      family = "FiraCode Nerd Font Mono";
      style = "Retina";
    };
    offset = {
      x = 0;
      y = 5;
    };
    glyph_offset = {
      x = 0;
      y = 0;
    };
  };

  Monospace = {
    normal = {
      family = "Monospace";
      style = "Normal";
    };
    bold = {
      family = "Monospace";
      style = "Medium";
    };
    italic = {
      family = "Monospace";
      style = "Italic";
    };
    offset = {
      x = 0;
      y = 7;
    };
    glyph_offset = {
      x = 0;
      y = 0;
    };
  };

  "IBM Plex Mono" = {
    normal = {
      family = "IBM Plex Mono";
      style = "Regular";
    };
    bold = {
      family = "IBM Plex Mono";
      style = "Medium";
    };
    italic = {
      family = "IBM Plex Mono";
      style = "Regular Italic";
    };
    offset = {
      x = 0;
      y = 0;
    };
    glyph_offset = {
      x = 0;
      y = 0;
    };
  };

  "Comic Mono" = {
    normal = {
      family = "Comic Mono";
      style = "Normal";
    };
    bold = {
      family = "Comic Mono";
      style = "Bold";
    };
    italic = {
      family = "Comic Mono";
      style = "Normal";
    };
    offset = {
      x = 1;
      y = 5;
    };
    glyph_offset = {
      x = 0;
      y = 0;
    };
  };

  "DM Mono" = {
    normal = {
      family = "DM Mono";
      style = "Regular";
    };
    bold = {
      family = "DM Mono";
      style = "Medium";
    };
    italic = {
      family = "DM Mono";
      style = "Light";
    };
    offset = {
      x = 0;
      y = 0;
    };
    glyph_offset = {
      x = 0;
      y = 0;
    };
  };

  Hack = {
    normal = {
      family = "Hack";
      style = "Regular";
    };
    bold = {
      family = "Hack";
      style = "Bold";
    };
    italic = {
      family = "Hack";
      style = "Italic";
    };
    offset = {
      x = 0;
      y = 0;
    };
    glyph_offset = {
      x = 0;
      y = 0;
    };
  };
}.${theme.font.monospace}
