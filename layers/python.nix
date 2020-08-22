{ pkgs , ...  }:

{

  packages = with pkgs; [
    python3Full
    poetry
  ];

  vimPlugins = with pkgs.vimPlugins; [
    coc-python
  ];

}
