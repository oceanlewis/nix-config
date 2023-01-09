{ pkgs, ... }:

let

  HOST_NAME = "Ghastly";
  USER = "david";
  HOME = "/home/${USER}";

  theme = import ../overlays/theme {
    name = "standard";
    variant = "black";
  };

in
{

  nixpkgs.overlays = pkgs.overlays ++ [ theme ];

  imports = [
    ../layers/common.nix
    ../programs/nushell
    ../programs/tmux.nix
    ../programs/starship.nix
    ../programs/git
    ../programs/helix
    ../programs/zellij
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "22.11";
    username = USER;
    homeDirectory = HOME;

    sessionVariables = {
      PAGER = "less -R";
      EDITOR = "hx";
      VISUAL = "hx";
      TERM = "xterm-256color";

      FZF_DEFAULT_COMMAND = "fd --type f";
      BAT_CONFIG_PATH = "${HOME}/.config/bat/config";
    };
  };
}
