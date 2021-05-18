{ pkgs, config, lib, ... }:

let

in {

  programs.home-manager.enable = true;

  # imports = [
  #   base git
  #   bash.home
  #   alacritty.home
  #   emacs.home
  #   zsh.home
  #   tmux.home
  #   starship.home
  #   nushell.home
  #   neovim
  # ];

  home = {
    stateVersion = "20.09";

    username      = USER;
    homeDirectory = HOME;

    packages =
      cloudPlatforms.packages ++
      beam.packages ++
      ruby.packages ++
      rust.packages ++
      python.packages ++
      nodejs.packages ++
      dhall.packages ++
      bash.packages ++
      lorri.packages ++
      [
        pkgs.lorri
        #pkgs.neuron-notes
      ];

    sessionVariables = {
      PAGER  = "less -R";
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERM   = "xterm-256color";

      XDG_CONFIG_HOME = "${HOME}/.config";
      XDG_DATA_HOME   = "${HOME}/.local/share";
      XDG_DATA_DIRS   = "${HOME}/.local/data";
      XDG_RUNTIME_DIR = "${HOME}/.local/run";

      # TODO: Refactor
      FZF_DEFAULT_COMMAND = "fd --type f";
      BAT_CONFIG_PATH     = "${HOME}/.config/bat/config";
    };

    file.".config/bat/config".text = ''
      --theme="${theme.bat.theme}"
    '';

  };

}
