let
  name = "gruvbox";
  variant = "dark";
  font.monospace = "DejaVu";

in
self: super: {
  theme = rec {
    inherit name variant font;

    bat.theme = {
      "standard-light" = "Coldark-Cold";
      "standard-dark" = "Sublime Snazzy";
      "standard-black" = "Sublime Snazzy";
      "gruvbox-light" = "gruvbox-light";
      "gruvbox-dark" = "gruvbox-dark";
      "gruvbox-black" = "gruvbox-dark";
      "monalisa-dark" = "gruvbox-dark";
      "monalisa-black" = "gruvbox-dark";
    }.${ "${name}-${variant}" } or (
      throw "Unsupported name-variant combination for bat theme: ${name}-${variant}"
    );

    delta = bat.theme;
  };
}
