{ config, pkgs, lib, ... }:

let

  USER = "david";
  HOME = "/home/${USER}";

  base           = import ../layers/base.nix            { inherit pkgs; inherit config; inherit lib; };
  git            = import ../programs/git/git.nix       { inherit pkgs; inherit config; inherit lib; };
  bash           = import ../programs/bash.nix          { inherit pkgs; inherit config; inherit lib; };
  cloudPlatforms = import ../layers/cloud-platforms.nix { inherit pkgs; inherit config; inherit lib; };
  beam           = import ../layers/beam.nix            { inherit pkgs; inherit config; inherit lib; };
  ruby           = import ../layers/ruby.nix            { inherit pkgs; inherit config; inherit lib; };
  rust           = import ../layers/rust.nix            { inherit pkgs; inherit config; inherit lib; };

  packages = import ../layers/development-packages.nix { pkgs = pkgs; } ++
             base.packages ++
             cloudPlatforms.packages ++
             git.packages ++
             bash.packages ++
             beam.packages ++
             ruby.packages ++
             rust.packages ++
             [ pkgs.ion ];

in

{

  home = {
    username      = USER;
    homeDirectory = HOME;
    packages      = packages;

    sessionVariables = {
      PAGER  = "less -R";
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERM   = "xterm-256color";
    };

    stateVersion = "20.09";
  };

  programs.home-manager.enable = true;

  imports = [
    git.program
    bash.program
    ../programs/zsh.nix
    ../programs/tmux.nix
    ../programs/neovim.nix
    ../programs/starship.nix
  ];

}
