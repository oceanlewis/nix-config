{
  pkgs,
  config,
  theme-config ? { },
}:
{
  nixpkgs.overlays = pkgs.overlays ++ [
    (import ../overlay/theme { config = theme-config; })
  ];

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
    stateVersion = config.state_version;
    username = config.user;
    homeDirectory = config.home;

    sessionVariables = {
      PAGER = "less -R";
      EDITOR = "hx";
      VISUAL = "hx";
      TERM = "xterm-256color";

      FZF_DEFAULT_COMMAND = "fd --type f";
      BAT_CONFIG_PATH = "${config.home}/.config/bat/config";
    };
  };
}
