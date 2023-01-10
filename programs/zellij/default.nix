{ pkgs, config, lib, ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      theme = pkgs.theme.zellij;
      layout = "compact";
      simplified_ui = true;
      pane_frames = false;
      themes = {
        gruvbox-light = {
          bg = [ 251 82 75 ];
          red = [ 205 75 69 ];
          green = [ 152 151 26 ];
          yellow = [ 215 153 33 ];
          blue = [ 69 133 136 ];
          magenta = [ 177 98 134 ];
          orange = [ 214 93 14 ];
          fg = [ 60 56 54 ];
          cyan = [ 104 157 106 ];
          black = [ 40 40 40 ];
          white = [ 213 196 161 ];
        };

        gruvbox-dark = {
          bg = [ 40 40 40 ];
          red = [ 204 36 29 ];
          green = [ 152 151 26 ];
          yellow = [ 215 153 33 ];
          blue = [ 69 133 136 ];
          magenta = [ 177 98 134 ];
          orange = [ 214 93 14 ];
          fg = [ 213 196 161 ];
          cyan = [ 104 157 106 ];
          black = [ 60 56 54 ];
          white = [ 251 241 199 ];
        };

        nord = {
          fg = [ 216 222 233 ];
          bg = [ 46 52 64 ];
          black = [ 59 66 82 ];
          red = [ 191 97 106 ];
          green = [ 163 190 140 ];
          yellow = [ 235 203 139 ];
          blue = [ 129 161 193 ];
          magenta = [ 180 142 173 ];
          cyan = [ 136 192 208 ];
          white = [ 229 233 240 ];
          orange = [ 208 135 112 ];
        };
      };
    };
  };
}