inputs@{ ... }:
final: prev:
let
  system = prev.pkgs.stdenv.hostPlatform.system;
  next-ls = inputs.next-ls.packages.${system}.default;
in
{
  inherit next-ls;
}
