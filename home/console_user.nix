{ pkgs
, config
}:

let

  HOME =
    if pkgs.stdenv.isLinux
    then "/home/${config.user}"
    else "/Users/${config.user}";

  theme = import ../overlays/theme { config = config.theme; };

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
    stateVersion = config.home.state_version;
    username = config.user;
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
