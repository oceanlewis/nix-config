{ pkgs, config, lib, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = pkgs.theme.helix;

      editor = {
        line-number = "relative";
      };
    };
  };
}
