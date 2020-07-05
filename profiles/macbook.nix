{ config, pkgs, lib, ... }:

let

  USER = "davidlewis";
  HOME = "/Users/${USER}";

  theme = import ../layers/theme.nix {
    inherit pkgs;

    theme   = "gruvbox";
    variant = "light";
    font    = "menlo";
  };

  base           = import ../layers/base.nix            { inherit pkgs; inherit config; inherit lib; };
  devPackages    = import ../layers/dev-packages.nix    { inherit pkgs;                              };
  cloudPlatforms = import ../layers/cloud-platforms.nix { inherit pkgs; inherit config; inherit lib; };
  beam           = import ../layers/beam.nix            { inherit pkgs; inherit config; inherit lib; };
  ruby           = import ../layers/ruby.nix            { inherit pkgs; inherit config; inherit lib; };
  rust           = import ../layers/rust.nix            { inherit pkgs; inherit config; inherit lib; };

  bash           = import ../programs/bash.nix      { inherit pkgs; inherit config; inherit lib; };
  git            = import ../programs/git/git.nix   { inherit pkgs; inherit config; inherit lib; inherit theme; };
  neovim         = import ../programs/neovim.nix    { inherit pkgs; inherit config; inherit lib; inherit theme; };
  alacritty      = import ../programs/alacritty.nix { inherit pkgs; inherit config; inherit lib; inherit theme; };

  packages = devPackages              ++
             base.packages            ++
             cloudPlatforms.packages  ++
             beam.packages            ++
             ruby.packages            ++
             rust.packages            ++
             git.packages             ++
             bash.packages;

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
      BAT_THEME       = theme.bat.theme;
    };

    stateVersion = "20.09";
  };

  programs.home-manager.enable = true;

  imports = [
    git.home
    bash.home
    alacritty.home
    neovim.home
    ../programs/zsh.nix
    ../programs/tmux.nix
    ../programs/starship.nix
  ];

}
