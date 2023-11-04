inputs@{ ... }:

final: prev:
let
  system = prev.pkgs.stdenv.system;
  next-ls = inputs.next-ls.packages.${system}.default;
in
{ inherit next-ls; }
