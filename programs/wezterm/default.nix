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
        color_scheme = '${pkgs.theme.wezterm}',
        hide_tab_bar_if_only_one_tab = true,
        tab_bar_at_bottom = true,
        use_fancy_tab_bar = false,
      }
    '';
  };
}
