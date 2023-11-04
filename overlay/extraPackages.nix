inputs@{ ... }:

final: prev:
let
  inherit (prev) pkgs;
  inherit (pkgs) stdenv;
  inherit (stdenv) system;

  next-ls = inputs.next-ls.packages.${system}.default;

in
{
  next-ls = next-ls;
}
