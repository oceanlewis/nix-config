{ pkgs }:
with pkgs;
[
  (nerdfonts.override {
    fonts = [
      "FiraCode"
      "DejaVuSansMono"
      "Hack"
      "IBMPlexMono"
      "Mononoki"
    ];
  })

  inter
]
