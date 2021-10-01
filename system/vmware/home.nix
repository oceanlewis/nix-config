{ pkgs, config, lib, ... }:

let

  layer = fileName: builtins.toPath "${HOME}/.config/nixpkgs/layers/${fileName}";
  program = fileName: builtins.toPath "${HOME}/.config/nixpkgs/programs/${fileName}";
  service = fileName: builtins.toPath "${HOME}/.config/nixpkgs/services/${fileName}";

  theme = import (layer "theme.nix") {
    inherit pkgs;
    theme = "gruvbox";
    variant = "light";
    fontFamily = "DejaVuSansMono";
    fontSize = 12.5;
  };

  base = import (layer "base.nix") { inherit pkgs lib; };
  rust = import (layer "rust.nix") { inherit pkgs; };
  git = import (program "git/git.nix") { inherit pkgs config lib theme; };
  alacritty = import (program "alacritty.nix") { inherit pkgs config lib theme; };

  neovim = import (program "neovim.nix") {
    inherit pkgs config lib theme;
    extraPlugins = lib.concatLists (
      [
        rust.vimPlugins
      ]
    );
  };

  shell = import (layer "posix-shell.nix") { inherit pkgs; };
  zsh = import (program "zsh.nix") { inherit pkgs shell; };
  bash = import (program "bash.nix") { inherit pkgs shell; };
  nushell = import (program "nushell.nix") { inherit pkgs; };
  tmux = import (program "tmux.nix") { inherit pkgs config lib; };
  starship = import (program "starship.nix") { inherit pkgs config lib; };
  lorri = import (service "lorri.nix") { inherit pkgs config lib; };

  USER = "davidlewis";
  HOME = "/home/${USER}";

in

{
  programs = {
    home-manager.enable = true;
  };

  imports = [
    base git
    bash zsh
    alacritty
    tmux
    starship
    nushell
    neovim
    lorri.home
  ];

  home = {
    stateVersion = "21.11";

    username      = USER;
    homeDirectory = HOME;

    sessionVariables = {
      PAGER = "less -R";
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERM = "xterm-256color";

      XDG_CONFIG_HOME = "${HOME}/.config";
      XDG_DATA_HOME = "${HOME}/.local/share";
      XDG_DATA_DIRS = "${HOME}/.local/data";
      XDG_RUNTIME_DIR = "${HOME}/.local/run";

      # TODO: Refactor
      FZF_DEFAULT_COMMAND = "fd --type f";
      BAT_CONFIG_PATH = "${HOME}/.config/bat/config";
    };

    file.".config/bat/config".text = ''
      --theme="${theme.bat.theme}"
    '';

    file."${HOME}/.config/nu/config.toml".onChange = ''
      echo Linking in nushell config file
      ln -sfv "${HOME}/.config/nu/config.toml" "${HOME}/Library/Application Support/org.nushell.nu/config.toml"
    '';
  };
}
