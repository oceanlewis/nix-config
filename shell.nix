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
  ]
  ++ lib.optionals stdenv.isDarwin [ ];
}
