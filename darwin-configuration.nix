{ config, pkgs, lib, ... }:

let

  layer = fileName: builtins.toPath "${HOME}/.config/nixpkgs/layers/${fileName}";
  program = fileName: builtins.toPath "${HOME}/.config/nixpkgs/programs/${fileName}";
  service = fileName: builtins.toPath "${HOME}/.config/nixpkgs/services/${fileName}";

  theme = import (layer "theme.nix") {
    inherit pkgs;
    theme = "gruvbox";
    variant = "black";
    fontFamily = "DejaVuSansMono";
    fontSize = 13.5;
  };

  base = import (layer "base.nix") { inherit pkgs lib; };
  cloudPlatforms = import (layer "cloud-platforms.nix") { inherit pkgs; };
  beam = import (layer "beam.nix") { inherit pkgs; };
  ruby = import (layer "ruby.nix") { inherit pkgs; };
  rust = import (layer "rust.nix") { inherit pkgs; };
  nodejs = import (layer "nodejs.nix") { inherit pkgs; };
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

  emacs = import (program "emacs.nix") { inherit pkgs; };
  shell = import (layer "posix-shell.nix") { inherit pkgs; };
  zsh = import (program "zsh.nix") { inherit pkgs shell; };
  bash = import (program "bash.nix") { inherit pkgs shell; };
  nushell = import (program "nushell.nix") { inherit pkgs; };
  tmux = import (program "tmux.nix") { inherit pkgs config lib; };
  starship = import (program "starship.nix") { inherit pkgs config lib; };
  lorri = import (service "lorri.nix") { inherit pkgs config lib; };

  HOST_NAME = "Thinky";
  USER = "davidlewis";
  HOME = "/Users/${USER}";

in
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nix;
    nixPath = lib.concatStringsSep ":" [
      "darwin-config=/Users/davidlewis/.nixpkgs/darwin-configuration.nix"
      "/Users/davidlewis/.nix-defexpr/channels"
    ];
  };

  imports = [
    <home-manager/nix-darwin>
  ];

  networking = {
    computerName = HOST_NAME;
    hostName = HOST_NAME;

    dns = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
  };

  fonts = {
    enableFontDir = true;
    fonts = [
      (
        pkgs.nerdfonts.override {
          fonts = [ "FiraCode" "DejaVuSansMono" "Hack" "IBMPlexMono" ];
        }
      )
    ];
  };

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    NSGlobalDomain = {
      InitialKeyRepeat = 25;
      KeyRepeat = 2;
    };
  };

  users.users."${USER}" = {
    home = HOME;
    isHidden = false;
    shell = pkgs.zsh;
  };

  environment = {
    # $ darwin-rebuild switch -I darwin-config=$HOME/.nixpkgs/darwin-configuration.nix
    darwinConfig = "$HOME/.nixpkgs/darwin-configuration.nix";

    # Append paths to the system PATH
    systemPath = [
      ''/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin''
    ];

    systemPackages = [
      pkgs.m-cli
      pkgs.xquartz
    ];
  };

  services = {
    nix-daemon.enable = true;
    lorri.enable = true;
    emacs = {
      enable = true;
      package = pkgs.emacsMacport;
    };
  };

  programs.zsh.enable = true;
  programs.bash.enable = true;

  home-manager = {
    users."${USER}" = { pkgs, ... }: {

      imports = [
        base
        git
        tmux
        bash
        zsh
        nushell
        starship
        neovim
        emacs
        alacritty
      ];

      programs.home-manager.enable = true;

      home = {
        stateVersion = "20.09";

        username = USER;
        homeDirectory = HOME;

        packages = lib.lists.concatMap (mod: mod.packages) [
          cloudPlatforms
          beam
          rust
          ruby
          nodejs
        ] ++ [ pkgs.direnv ];

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
          GOPATH = "${HOME}/Developer/go/";
        };

        file.".config/bat/config".text = ''
          --theme="${theme.bat.theme}"
        '';

        file.".ideavimrc".text = ''
          " Enable relative line numbers
          set relativenumber
          set number
        
          " Integrate with system clipboard
          set clipboard=unnamedplus,unnamed
          let mapleader = " "
          " yank to system clipboard
          set clipboard=unnamed
          set clipboard+=ideaput
        
          "" Tab navigation
          nnoremap <A-l> :tabnext<CR>
          nnoremap <A-h> :tabprevious<CR>
          nnoremap <A-BS> :tabclose<CR>
        
          "" Code Navigation
          nnoremap <S-CR> :action GotoDeclaration<CR>
        '';

        file."${HOME}/.config/nu/config.toml".onChange = ''
          echo Linking in nushell config file
          ln -sfv "${HOME}/.config/nu/config.toml" "${HOME}/Library/Application Support/org.nushell.nu/config.toml"
        '';
      };
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
