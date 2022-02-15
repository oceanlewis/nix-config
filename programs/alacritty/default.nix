{ config, lib, pkgs, ... }:

with pkgs; let

  font = import ./fonts.nix { inherit pkgs; };
  colors = import ./colors.nix { inherit pkgs; };
  key_bindings = import ./key_bindings.nix { inherit pkgs; };

in
{
  programs.alacritty = {
    enable = true;

    settings = {
      inherit font colors key_bindings;

      window = {
        title = "";
        dynamic_title = false;
        dimensions = { columns = 132; lines = 38; };
        padding = { x = 10; y = 10; };
        opacity = 0.95;
      } // (
        if stdenv.isDarwin then {
          decorations = "none";
          use_thin_strokes = true;
        }
        else if stdenv.isLinux then {
          gtk_theme_variant =
            if theme.alacritty.variant == "light" then "light" else "dark";
        }
        else { }
      );

      draw_bold_text_with_bright_colors = true;

      cursor.style.blinking = "Always";
      mouse.hide_when_typing = true;
    };
  };
}
