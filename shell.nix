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
    entr
  ] ++ lib.optionals stdenv.isDarwin [ ];
}
