{ pkgs }:
with pkgs;

mkShell {
  buildInputs = [
    helix
    ripgrep
    fd
    bat
    tmux
    just
    ncurses
    git
  ]
  ++ lib.optionals stdenv.isDarwin [ ];
}
