{ pkgs }:

let
  inherit (pkgs) theme;

  defaults = {
    size = 13.5;
    offset = { x = 0; y = 0; };
    glyph_offset = { x = 0; y = 0; };
  };

  fontConfig = defaults // {
    "Menlo" = {
      normal = { family = "MesloLGL Nerd Font"; style = "Regular"; };
      bold = { family = "MesloLGL Nerd Font"; style = "Bold"; };
      italic = { family = "MesloLGL Nerd Font"; style = "Italic"; };
      size = defaults.size + 1.0;
    };

    "Monaco" = {
      normal = { family = "Monaco"; style = "Regular"; };
      bold = { family = "Monaco"; style = "Regular"; };
      italic = { family = "Monaco"; style = "Regular"; };
      offset = { x = 1; y = 4; };
    };

    "DejaVu" = {
      normal = { family = "DejaVuSansM Nerd Font"; style = "Book"; };
      bold = { family = "DejaVuSansM Nerd Font"; style = "Bold"; };
      italic = { family = "DejaVuSansM Nerd Font"; style = "Oblique"; };
      offset = { x = 1; y = 3; };
    };

    "Go" = {
      normal = { family = "GoMono Nerd Font"; style = "Regular"; };
      bold = { family = "GoMono Nerd Font"; style = "Bold"; };
      italic = { family = "GoMono Nerd Font"; style = "Italic"; };
      offset = { x = 1; y = 3; };
    };

    "ShureTech" = {
      normal = { family = "ShureTechMono Nerd Font"; style = "Regular"; };
      bold = { family = "ShureTechMono Nerd Font"; style = "Bold"; };
      italic = { family = "ShureTechMono Nerd Font"; style = "Italic"; };
      offset = { x = 2; y = 2; };
      size = 15;
    };

    "SF Mono" = {
      normal = { family = "SF Mono"; style = "Regular"; };
      bold = { family = "SF Mono"; style = "Semibold"; };
      italic = { family = "SF Mono"; style = "Light Italic"; };
      offset = { x = 0; y = 3; };
    };

    "Fira Mono" = {
      normal = { family = "Fira Mono"; style = "Normal"; };
      bold = { family = "Fira Mono"; style = "Medium"; };
      italic = { family = "Fira Mono"; style = "Italic"; };
      offset = { x = 0; y = 5; };
    };

    "Fira Code" = {
      normal = { family = "FiraCode Nerd Font Mono"; style = "Retina"; };
      bold = { family = "FiraCode Nerd Font Mono"; style = "SemiBold"; };
      italic = { family = "FiraCode Nerd Font Mono"; style = "Retina"; };
      offset = { x = 0; y = 5; };
    };

    Monospace = {
      normal = { family = "Monospace"; style = "Normal"; };
      bold = { family = "Monospace"; style = "Medium"; };
      italic = { family = "Monospace"; style = "Italic"; };
      offset = { x = 0; y = 7; };
    };

    "IBM Plex Mono" = {
      normal = { family = "BlexMono Nerd Font Mono"; style = "Book"; };
      bold = { family = "BlexMono Nerd Font Mono"; style = "Medium"; };
      italic = { family = "BlexMono Nerd Font Mono"; style = "Italic"; };
      offset = { x = 0; y = 0; };
    };

    "Comic Mono" = {
      normal = { family = "Comic Mono"; style = "Normal"; };
      bold = { family = "Comic Mono"; style = "Bold"; };
      italic = { family = "Comic Mono"; style = "Normal"; };
      offset = { x = 1; y = 5; };
    };

    "DM Mono" = {
      normal = { family = "DM Mono"; style = "Regular"; };
      bold = { family = "DM Mono"; style = "Medium"; };
      italic = { family = "DM Mono"; style = "Light"; };
    };

    Hack = {
      normal = { family = "Hack"; style = "Regular"; };
      bold = { family = "Hack"; style = "Bold"; };
      italic = { family = "Hack"; style = "Italic"; };
    };

    "Victor Mono" = {
      normal = { family = "Victor Mono"; style = "Regular"; };
      bold = { family = "Victor Mono"; style = "Bold"; };
      italic = { family = "Victor Mono"; style = "Italic"; };
    };

    "JetBrains Mono" = {
      normal = { family = "JetBrainsMono Nerd Font"; style = "Regular"; };
      bold = { family = "JetBrainsMono Nerd Font"; style = "Bold"; };
      italic = { family = "JetBrainsMono Nerd Font"; style = "Italic"; };
    };

    "Cascadia Code" = {
      normal = { family = "CaskaydiaCove Nerd Font"; style = "Regular"; };
      bold = { family = "CaskaydiaCove Nerd Font"; style = "Bold"; };
      italic = { family = "CaskaydiaCove Nerd Font"; style = "Italic"; };
    };
  }.${theme.font.monospace};

in
fontConfig
