{
  username,
  homeDirectory,
  stateVersion,
  ...
}:
{
  imports = [
    ../layers/common.nix
    ../programs/nushell
    ../programs/tmux.nix
    ../programs/starship.nix
    ../programs/git
    ../programs/helix
    ../programs/zellij
    # ../programs/wezterm
  ];

  xdg.enable = true;
  programs.home-manager.enable = true;
  programs.rio.enable = true;
  programs.wezterm.enable = true;
  stylix.enable = true;

  home = {
    inherit stateVersion username homeDirectory;

    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.docker/bin"
    ];

    sessionVariables = {
      PAGER = "less -R";
      EDITOR = "hx";
      VISUAL = "hx";
      TERM = "xterm-256color";

      # TODO: Refactor
      FZF_DEFAULT_COMMAND = "fd --type f";
      BAT_CONFIG_PATH = "${homeDirectory}/.config/bat/config";
      GOPATH = "${homeDirectory}/Developer/go/";
    };
  };
}
