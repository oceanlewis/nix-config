{ config, pkgs, ... }:

let

  USER = "davidlewis";
  HOME = "/Users/${USER}";

in

{

  home = {
    username      = USER;
    homeDirectory = HOME;
    packages      = import ../layers/development-packages.nix { };

    sessionVariables = {
      PAGER           = "less -R";
      EDITOR          = "nvim";
      VISUAL          = "nvim";
      XDG_CONFIG_HOME = "${HOME}/.config";
      XDG_DATA_HOME   = "${HOME}/.local/share";
      XDG_DATA_DIRS   = "${HOME}/.local/data";
      XDG_RUNTIME_DIR = "${HOME}/.local/run";
    };

    stateVersion = "20.09";
  };

  programs.home-manager.enable = true;

  imports = [
    ../programs/bash.nix
    ../programs/zsh.nix
    ../programs/tmux.nix
    ../programs/neovim.nix
    ../programs/starship.nix
  ];

}
