{ config, lib, pkgs, ... }:

let
  inherit (pkgs) theme;
  inherit (theme) name variant;

  defaults = {
    size = 14;
    light.normal.weight = 500;
    line_height = 1.4;
  };

  font = defaults // {
    "Menlo" = { family = "MesloLGL Nerd Font"; line_height = 1.0; };
    "Monaco" = { family = "Monaco"; };
    "DejaVu" = { family = "DejaVuSansMono Nerd Font"; };
    "Go" = { family = "GoMono Nerd Font"; };
    "ShureTech" = { family = "ShureTechMono Nerd Font"; size = defaults.size + 1.5; };
    "SF Mono" = { family = "SF Mono"; };
    "Fira Mono" = { family = "Fira Mono"; };
    "Fira Code" = { family = "FiraCode Nerd Font Mono"; };
    "IBM Plex Mono" = { family = "BlexMono Nerd Font Mono"; size = defaults.size + 0.5; };
    "Comic Mono" = { family = "Comic Mono"; };
    "DM Mono" = { family = "DM Mono"; };
    "Hack" = { family = "Hack"; };
    "Victor Mono" = { family = "Victor Mono"; };
    "JetBrains Mono" = { family = "JetBrainsMono Nerd Font"; };
    "Cascadia Code" = { family = "CaskaydiaCove Nerd Font"; size = defaults.size + 1.0; };
  }.${theme.font.monospace};

  font_config = font:
    let options =
      if variant == "light"
      then "{weight=${toString font.light.normal.weight}}"
      else "{}";
    in
    "wezterm.font('${font.family}', ${options})";

  fancy_tab_bar = use_custom:
    if use_custom then
      ''
        config.window_frame = {
          font = wezterm.font { family = 'Inter', weight = 'Bold' },
          font_size = 10.0,
          -- The overall background color of the tab bar when
          -- the window is focused
          active_titlebar_bg = '#000000',
          -- The overall background color of the tab bar when
          -- the window is not focused
          inactive_titlebar_bg = '#333333',
        }

        config.window = {}
        config.window.colors = {
          tab_bar = {
            -- The color of the inactive tab bar edge/divider
            inactive_tab_edge = '#575757',
          },
        }
      ''
    else "config.use_fancy_tab_bar = false";

in
{
  programs.wezterm = {
    enable = true;

    colorSchemes = { };
    extraConfig =
      ''
        local config = {}
        config.font = ${font_config font}
        config.font_size = ${toString font.size}
        config.line_height = ${toString font.line_height}
        config.color_scheme = '${theme.wezterm}'
        config.hide_tab_bar_if_only_one_tab = true
        config.tab_bar_at_bottom = true

        ${fancy_tab_bar false}
        return config
      '';
  };
}
