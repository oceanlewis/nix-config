{ pkgs , ...  }:

with pkgs;

{

  /*
   * See the docs on Ruby in NixPkgs
   * - https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/ruby.section.md
   * - https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/ruby-modules/with-packages/default.nix
   */
  packages = [
    (ruby.withPackages (selector:
      with selector; [
        nokogiri
        pry
      ]
    ))
    solargraph
  ];

}