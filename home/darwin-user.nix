{ username
, homeDirectory
, stateVersion
, ...
}:
{
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
    inherit stateVersion username homeDirectory;

    sessionVariables = {
      PATH = "$PATH:$HOME/.local/bin";
      PAGER = "less -R";
      EDITOR = "hx";
      VISUAL = "hx";
      TERM = "xterm-256color";

      XDG_CONFIG_HOME = "${homeDirectory}/.config";
      XDG_DATA_HOME = "${homeDirectory}/.local/share";
      XDG_DATA_DIRS = "${homeDirectory}/.local/data";
      XDG_RUNTIME_DIR = "${homeDirectory}/.local/run";

      # TODO: Refactor
      FZF_DEFAULT_COMMAND = "fd --type f";
      BAT_CONFIG_PATH = "${homeDirectory}/.config/bat/config";
      GOPATH = "${homeDirectory}/Developer/go/";
    };
  };
}
