{ pkgs ? import <nixpkgs> {} }:

let

  rustPlatform = pkgs.rustPlatform;
  licence = pkgs.lib.licenses.gpl3;
  homepage = "https://github.com/nivekuil/rip";
  version = "0.13.1";
  crateName = "rm-improved";
  description = "rip is a command-line deletion tool focused on safety, ergonomics, and performance. It favors a simple interface, and does not implement the xdg-trash spec or attempt to achieve the same goals.";

in rustPlatform.buildRustPackage rec {
  inherit version;
  pname = "rip";

  src = pkgs.fetchCrate {
    inherit crateName version;
    sha256 = "05sa3151hw7cjw18rxv2584425yy9q0lj5x32gx0akxc0lmfwgr4";
  };

  cargoSha256 = "0fncybw4m1lbnr3yflyljyxz6qva2ki2jdp8vvf94rz52wnmzls9";

  meta = with pkgs.lib; {
    inherit licence homepage description;
  };
}
