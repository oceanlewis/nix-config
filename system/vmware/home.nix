{ pkgs, config, lib, ... }:

let

  layer = fileName: builtins.toPath "${HOME}/.config/nixpkgs/layers/${fileName}";
  program = fileName: builtins.toPath "${HOME}/.config/nixpkgs/programs/${fileName}";
  service = fileName: builtins.toPath "${HOME}/.config/nixpkgs/services/${fileName}";

  theme = import (layer "theme.nix") {
    inherit pkgs;
    theme = "standard";
    variant = "dark";
    fontFamily = "DejaVuSansMono";
    fontSize = 12.5;
  };

  git = import (program "git/git.nix") { inherit pkgs config lib theme; };
  alacritty = import (program "alacritty.nix") {
    inherit pkgs config lib theme;
  };

  neovim = import (program "neovim.nix") {
    inherit pkgs config lib theme;
  };

  USER = "armstrong";
  HOME = "/home/${USER}";

in

{
  programs = {
    home-manager.enable = true;
  };

  services.lorri.enable = true;

  imports = [
    ./layers/common.nix
    ./services/lorri.nix
    ./programs/vscode.nix
    ./programs/nushell.nix
    ./programs/tmux.nix
    ./programs/starship.nix
    alacritty
    git
    neovim
  ];

  home = {
    stateVersion = "21.11";

    username = USER;
    homeDirectory = HOME;

    sessionVariables = {
      PAGER = "less -R";
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERM = "xterm-256color";

      # TODO: Refactor
      FZF_DEFAULT_COMMAND = "fd --type f";
      BAT_CONFIG_PATH = "${HOME}/.config/bat/config";
    };

    file.".config/bat/config".text = ''
      --theme="${theme.bat.theme}"
    '';

    file.".gdbinit".text = ''
      define hook-quit
        set confirm off
      end
    '';
  };
}
