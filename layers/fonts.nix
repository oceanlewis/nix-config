{ pkgs }:
with pkgs;
[
  (nerdfonts.override {
    fonts = [
      "FiraCode"
      "DejaVuSansMono"
      "Hack"
      "IBMPlexMono"
      "Go-Mono"
      "ShareTechMono"
      "Meslo"
    ];
  })

  victor-mono
  inter
]
