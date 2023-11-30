{ pkgs, lib, ... }:

let
  inherit (pkgs) theme;
  inherit (theme) variant;
  inherit (lib) lists;

  defaults = {
    size = 14;
    line_height = 1.4;
    light.normal.weight = 500;
    dark.normal.weight = 500;
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
    "JetBrains Mono" = {
      family = "JetBrainsMono Nerd Font";
      light.normal.weight = 700;
      dark.normal.weight = 400;
    };
    "Cascadia Code" = {
      family = "CaskaydiaCove Nerd Font";
      size = defaults.size + 1.0;
    };
  }.${theme.font.monospace};

  font_config = font:
    let
      options =
        if variant == "light"
        then "{weight=${toString font.light.normal.weight}}"
        else "{weight=${toString font.dark.normal.weight}}";
    in
    "wezterm.font('${font.family}', ${options})";

  fancy_tab_bar = use_custom:
    if use_custom then null
    else "config.use_fancy_tab_bar = false";

  background_variant_override = variant:
    if variant == "black"
    then "config.colors = { background = '#000000' }"
    else null;

  window_decorations =
    if pkgs.stdenv.isDarwin
    then "RESIZE|INTEGRATED_BUTTONS"
    else "RESIZE|INTEGRATED_BUTTONS";

  window_padding = {
      left = "'1cell'";
      right = "'1cell'";
      top = "'0.5cell'";
      bottom = "'0.5cell'";
    } //
    (if pkgs.stdenv.isDarwin
    then {top = "'65px'";}
    else {});

in
{
  programs.wezterm = {
    enable = true;
    colorSchemes = { };
    extraConfig = builtins.concatStringsSep "\n"
      (lists.filter (e: e != null) [
        ''
          local act = wezterm.action
          local config = {}
          config.font = ${font_config font}
          config.font_size = ${toString font.size}
          config.line_height = ${toString font.line_height}
          config.color_scheme = '${theme.wezterm}'
          config.hide_tab_bar_if_only_one_tab = true
          config.tab_bar_at_bottom = true
          config.native_macos_fullscreen_mode = false
          config.window_decorations = "${window_decorations}"
          config.keys = {
            { key = '+', mods = 'SUPER', action = act.IncreaseFontSize },
            { key = 'f', mods = 'SUPER|CTRL', action = act.ToggleFullScreen },
          }
          config.window_padding = {
            left = ${window_padding.left},
            right = ${window_padding.right},
            top = ${window_padding.top},
            bottom = ${window_padding.bottom},
          }
          config.window_close_confirmation = 'NeverPrompt'
        ''
        (fancy_tab_bar true)
        (background_variant_override variant)
        "return config"
      ]
      );
  };
}


