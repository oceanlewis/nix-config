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
    watchexec
  ]
  ++ lib.optionals stdenv.isDarwin [ ];
}
