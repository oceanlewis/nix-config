let

  theme = "gruvbox";
  variant = "black";
  fontFamily = "Mononoki";
  fontSize = 12.5;

in
self: super: {
  theme = rec {
    name = theme;
    inherit variant;
    font = { monospace = fontFamily; };

    neovim = {
      colorScheme = {
        "standard-light" = "rdark-terminal2";
        "standard-dark" = "rdark-terminal2";
        "standard-black" = "rdark-terminal2";
        "gruvbox-light" = "gruvbox8";
        "gruvbox-dark" = "gruvbox8";
        "gruvbox-black" = "gruvbox8";
      }.${ "${theme}-${variant}" }
        or (throw "Unsupported theme-variant combination for neovim: ${theme}-${variant}");

      background =
        if variant == "light" then "light"
        else "dark";
    };

    bat.theme =
      {
        "standard-light" = "GitHub";
        "standard-dark" = "Sublime Snazzy";
        "standard-black" = "Sublime Snazzy";
        "gruvbox-light" = "gruvbox-light";
        "gruvbox-dark" = "gruvbox-dark";
        "gruvbox-black" = "gruvbox-dark";
      }.${ "${theme}-${variant}" }
        or (throw "Unsupported theme-variant combination for bat theme: ${theme}-${variant}");

    delta = bat.theme;
  };
}
