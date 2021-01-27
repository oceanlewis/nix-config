{ pkgs , ...  }:
{
  packages = [ pkgs.dhall ];
  vimPlugins = [ pkgs.vimPlugins.dhall-vim ];
}
