{ pkgs, lib, ... }:
let
  inherit (pkgs) theme;

  modeBackground = {
    light = "#F8F8F3";
    dark = "#000000";
    black = "#000000";
  }.${theme.variant};

  defaultLayout = builtins.replaceStrings
    [ "$MODE_BG" ]
    [ modeBackground ]
    (builtins.readFile ./zjstatus_layout.kdl);
in
{
  home.packages = [ pkgs.zjstatus ];
  xdg.configFile."zellij/layouts/default.kdl".text = defaultLayout;
  programs.zellij = lib.attrsets.recursiveUpdate
    (lib.attrsets.optionalAttrs pkgs.stdenv.isDarwin
      { settings.copy_command = "pbcopy"; })
    {
      enable = true;
      settings = {
        theme = pkgs.theme.zellij;
        # default_layout = "compact";
        pane_frames = false;

        themes = {
          dracula-custom = {
            fg = [ 80 80 80 ];
            bg = [ 40 42 54 ];
            black = [ 0 0 0 ];
            red = [ 0 0 0 ];
            green = [ 193 145 201 ];
            yellow = [ 241 250 140 ];
            blue = [ 98 114 164 ];
            magenta = [ 255 121 198 ];
            cyan = [ 139 233 253 ];
            white = [ 80 80 80 ];
            orange = [ 255 184 108 ];
          };

          one-half-dark-custom = {
            fg = [ 220 223 228 ];
            bg = [ 40 44 52 ];
            black = [ 35 35 35 ];
            red = [ 227 63 76 ];
            green = [ 152 195 121 ];
            yellow = [ 229 192 123 ];
            blue = [ 97 175 239 ];
            magenta = [ 198 120 221 ];
            cyan = [ 86 182 194 ];
            white = [ 233 225 254 ];
            orange = [ 216 133 76 ];
          };

          gruvbox-light-custom = {
            fg = [ 213 196 161 ];
            bg = [ 251 82 75 ];
            black = [ 40 40 40 ];
            red = [ 205 75 69 ];
            green = [ 167 92 124 ];
            yellow = [ 215 153 33 ];
            blue = [ 69 133 136 ];
            magenta = [ 177 98 134 ];
            cyan = [ 104 157 106 ];
            white = [ 213 196 161 ];
            orange = [ 214 93 14 ];
          };

          gruvbox-dark-medium = {
            fg = [ 213 196 161 ];
            bg = [ 40 40 40 ];
            black = [ 40 40 40 ];
            red = [ 204 36 29 ];
            green = [ 152 151 26 ];
            yellow = [ 215 153 33 ];
            blue = [ 69 133 136 ];
            magenta = [ 177 98 134 ];
            cyan = [ 104 157 106 ];
            white = [ 251 241 199 ];
            orange = [ 214 93 14 ];
          };

          gruvbox-dark-black = {
            fg = [ 213 196 161 ];
            bg = [ 40 40 40 ];
            black = [ 0 0 0 ];
            red = [ 204 36 29 ];
            green = [ 152 151 26 ];
            yellow = [ 215 153 33 ];
            blue = [ 69 133 136 ];
            magenta = [ 177 98 134 ];
            cyan = [ 104 157 106 ];
            white = [ 251 241 199 ];
            orange = [ 214 93 14 ];
          };

          #   nord = {
          #     fg = [ 216 222 233 ];
          #     bg = [ 46 52 64 ];
          #     black = [ 59 66 82 ];
          #     red = [ 191 97 106 ];
          #     green = [ 163 190 140 ];
          #     yellow = [ 235 203 139 ];
          #     blue = [ 129 161 193 ];
          #     magenta = [ 180 142 173 ];
          #     cyan = [ 136 192 208 ];
          #     white = [ 229 233 240 ];
          #     orange = [ 208 135 112 ];
          #   };
        };
      };
    };
}
