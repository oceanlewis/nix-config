{ pkgs , ...  }:

with pkgs;

{

  packages = [
    dhall
    dhall-json
    #dhall-nix # marked as broken
  ];

  vimPlugins = with vimPlugins; [
    dhall-vim
  ];

}
