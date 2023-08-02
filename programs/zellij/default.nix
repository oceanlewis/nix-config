{ pkgs, lib, ... }:
{
  programs.zellij = lib.attrsets.recursiveUpdate
    (lib.attrsets.optionalAttrs pkgs.stdenv.isDarwin
      { settings.copy_command = "pbcopy"; })
    {
      enable = true;
      settings = {
        theme = pkgs.theme.zellij;
        # default_layout = "compact";
        # simplified_ui = true;
        pane_frames = false;

        themes = {
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

          gruvbox-dark = {
            fg = [ 213 196 161 ];
            bg = [ 40 40 40 ];
            black = [ 60 56 54 ];
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
