{ pkgs
, config
, theme-config ? { }
}:
{
  nixpkgs.overlays = pkgs.overlays ++ [
    (import ../overlays/theme { config = theme-config; })
    (import ../overlays/ipython.nix)
    (import ../overlays/vimPlugins.nix)
  ];

  imports = [
    ../layers/common.nix
    ../programs/nushell
    ../programs/tmux.nix
    ../programs/starship.nix
    ../programs/git
    ../programs/alacritty
    ../programs/helix
    ../programs/zellij
    ../programs/wezterm
    ../programs/neovim
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = config.state_version;
    username = config.user;
    homeDirectory = config.home;

    sessionVariables = {
      PATH = "$PATH:$HOME/.local/bin";
      PAGER = "less -R";
      EDITOR = "hx";
      VISUAL = "nvim";
      TERM = "xterm-256color";
      SHELL = "${pkgs.zsh}/bin/zsh";

      XDG_CONFIG_HOME = "${config.home}/.config";
      XDG_DATA_HOME = "${config.home}/.local/share";
      XDG_DATA_DIRS = "${config.home}/.local/data";
      XDG_RUNTIME_DIR = "${config.home}/.local/run";

      # TODO: Refactor
      FZF_DEFAULT_COMMAND = "fd --type f";
      BAT_CONFIG_PATH = "${config.home}/.config/bat/config";
      GOPATH = "${config.home}/Developer/go/";
    };
  };
}
