{ pkgs, ... }:
{

  home.programs.emacs = {
    enable = true;
    package = pkgs.emacs;

    extraPackages =
      epkgs: [
        # epkgs.evil
        # epkgs.doom
        # epkgs.magit
      ];
  };

}
