{ config, lib, pkgs, ... }:

let
  inherit (pkgs) theme;
  inherit (theme) name variant;

  defaults.size = 13.5;

  font = defaults // {
    "Menlo" = { family = "MesloLGL Nerd Font"; size = defaults.size + 1.0; };
    "Monaco" = { family = "Monaco"; };
    "DejaVu" = { family = "DejaVuSansMono Nerd Font"; };
    "Go" = { family = "GoMono Nerd Font"; };
    "ShureTech" = { family = "ShureTechMono Nerd Font"; size = defaults.size + 1.5; };
    "SF Mono" = { family = "SF Mono"; };
    "Fira Mono" = { family = "Fira Mono"; };
    "Fira Code" = { family = "FiraCode Nerd Font Mono"; };
    "IBM Plex Mono" = { family = "BlexMono Nerd Font Mono"; };
    "Comic Mono" = { family = "Comic Mono"; };
    "DM Mono" = { family = "DM Mono"; };
    "Hack" = { family = "Hack"; };
    "Victor Mono" = { family = "Victor Mono"; };
  }.${theme.font.monospace};

  color_scheme = rec {
    standard.light = "Mexico Light (base16)";
    # standard.light = "iA Light (base16)";
    # standard.light = "Heetch Light (base16)";
    # standard.light = "Humanoid light (base16)";

    # standard.dark = "Invisibone (terminal.sexy)";
    standard.dark = "laserwave (Gogh)";
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

    # nord.dark = "nord";
  }.${name}.${variant}
    or (throw "Unsupported theme-variant combination for wezterm: ${name}.${variant}");

  adjusted_font = font:
    if variant == "light"
    then "'${font}', { weight = 'Bold' }"
    else "'${font}'";

in
{
  programs.wezterm = {
    enable = true;

    colorSchemes = { };
    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        font = wezterm.font(${adjusted_font font.family}),
        font_size = ${toString font.size},
        color_scheme = '${color_scheme}',
        hide_tab_bar_if_only_one_tab = true,
        tab_bar_at_bottom = true,
        use_fancy_tab_bar = false,
      }
    '';
  };
}
