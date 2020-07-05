{ config, pkgs, lib, ... }:

let

  USER = "davidlewis";
  HOME = "/Users/${USER}";

  theme = import ../layers/theme.nix {
    inherit pkgs;

    alacritty = {
      theme   = "gruvbox";
      variant = "light";
      font    = "menlo";
    };
  };

  base           = import ../layers/base.nix            { inherit pkgs; inherit config; inherit lib; };
  git            = import ../programs/git/git.nix       { inherit pkgs; inherit config; inherit lib; };
  bash           = import ../programs/bash.nix          { inherit pkgs; inherit config; inherit lib; };
  cloudPlatforms = import ../layers/cloud-platforms.nix { inherit pkgs; inherit config; inherit lib; };
  beam           = import ../layers/beam.nix            { inherit pkgs; inherit config; inherit lib; };
  ruby           = import ../layers/ruby.nix            { inherit pkgs; inherit config; inherit lib; };
  rust           = import ../layers/rust.nix            { inherit pkgs; inherit config; inherit lib; };
  alacritty      = import ../programs/alacritty.nix     { inherit pkgs; inherit config; inherit lib;
                                                          inherit theme; };

  packages = import ../layers/development-packages.nix { pkgs = pkgs; } ++
             base.packages ++
             cloudPlatforms.packages ++
             git.packages ++
             bash.packages ++
             beam.packages ++
             ruby.packages ++
             rust.packages;

in

{

  home = {
    username      = USER;
    homeDirectory = HOME;
    packages      = packages;

    sessionVariables = {
      PAGER           = "less -R";
      EDITOR          = "nvim";
      VISUAL          = "nvim";
      TERM            = "xterm-256color";
      XDG_CONFIG_HOME = "${HOME}/.config";
      XDG_DATA_HOME   = "${HOME}/.local/share";
      XDG_DATA_DIRS   = "${HOME}/.local/data";
      XDG_RUNTIME_DIR = "${HOME}/.local/run";
    };

    stateVersion = "20.09";
  };

  programs.home-manager.enable = true;

  imports = [
    git.home
    bash.home
    alacritty.home
    ../programs/zsh.nix
    ../programs/tmux.nix
    ../programs/neovim.nix
    ../programs/starship.nix
  ];

}
