{ lib
, pkgs
, rustPlatform
, ...
}:

let

  # inherit (lib) updateFromGitHub;
  inherit (pkgs) fetchFromGitHub;
  inherit (pkgs.stdenv) mkDerivation;
  # inherit (pkgs.lib) importJSON;
  # inherit (rustPlatform) buildRustPackage;
  # inherit (rustPlatform.rust) rustc cargo;

  # src = fetchFromGitHub "https://github.com/davidarmstronglewis/term-status.git";

in mkDerivation rec {
  name = "term_status";

  src = fetchFromGitHub {
    owner = "davidarmstronglewis";
    repo = "term-status";
    rev = "${version}";
    sha256 = "0y5d1n6hkw85jb3rblcxqas2fp82h3nghssa4xqrhqnz25l799pj";
  };
}