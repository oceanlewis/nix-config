{ pkgs, ... }:

let

  HOST_NAME = "Armstrong";
  USER = "david.lewis";
  HOME = "/Users/${USER}";

in
{

  nixpkgs.overlays = pkgs.overlays ++ [
    (import ../../overlays/theme {
      name = "standard";
      variant = "dark";
    })
    (import ../../overlays/ipython.nix)
    (import ../../overlays/vimPlugins.nix)
  ];

  imports = [
    ../../layers/common.nix
    ../../programs/nushell
    ../../programs/tmux.nix
    ../../programs/starship.nix
    ../../programs/git
    ../../programs/alacritty
    ../../programs/helix
    ../../programs/zellij
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "21.11";
    username = USER;
    homeDirectory = HOME;

    sessionVariables = {
      PAGER = "less -R";
      EDITOR = "hx";
      VISUAL = "nvim";
      TERM = "xterm-256color";

      XDG_CONFIG_HOME = "${HOME}/.config";
      XDG_DATA_HOME = "${HOME}/.local/share";
      XDG_DATA_DIRS = "${HOME}/.local/data";
      XDG_RUNTIME_DIR = "${HOME}/.local/run";

      # TODO: Refactor
      FZF_DEFAULT_COMMAND = "fd --type f";
      BAT_CONFIG_PATH = "${HOME}/.config/bat/config";
      GOPATH = "${HOME}/Developer/go/";
    };
  };
}
