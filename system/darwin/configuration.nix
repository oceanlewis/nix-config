{ config, pkgs, lib, ... }:

let

  layer = fileName: builtins.toPath "${HOME}/.config/nixpkgs/layers/${fileName}";
  program = fileName: builtins.toPath "${HOME}/.config/nixpkgs/programs/${fileName}";
  service = fileName: builtins.toPath "${HOME}/.config/nixpkgs/services/${fileName}";

  theme = import (layer "theme.nix") {
    inherit pkgs;
    theme      = "gruvbox";
    variant    = "light";
    fontFamily = "Menlo";
    fontSize   = 13.5;
  };

  base = import (layer "base.nix") { inherit pkgs lib; };
  cloudPlatforms = import (layer "cloud-platforms.nix") { inherit pkgs; };
  beam = import (layer "beam.nix") { inherit pkgs; };
  ruby = import (layer "ruby.nix") { inherit pkgs; };
  rust = import (layer "rust.nix") { inherit pkgs; };
  python = import (layer "python.nix") { inherit pkgs; };
  nodejs = import (layer "nodejs.nix") { inherit pkgs; };
  dhall = import (layer "dhall.nix") { inherit pkgs; };
  git = import (program "git/git.nix") { inherit pkgs config lib theme; };
  alacritty = import (program "alacritty.nix") { inherit pkgs config lib theme; };

  neovim = import (program "neovim.nix") {
    inherit pkgs config lib theme;
    extraPlugins = lib.concatLists([
      dhall.vimPlugins
      ruby.vimPlugins
      python.vimPlugins
      rust.vimPlugins
    ]);
  };

  emacs = import (program "emacs.nix") { inherit pkgs; };
  shell = import (layer "posix-shell.nix") { inherit pkgs; };
  zsh = import (program "zsh.nix") { inherit pkgs shell; };
  bash = import (program "bash.nix") { inherit pkgs shell; };
  nushell = import (program "nushell.nix") { inherit pkgs; };
  tmux = import (program "tmux.nix") { inherit pkgs config lib; };
  starship = import (program "starship.nix") { inherit pkgs config lib; };
  lorri = import (service "lorri.nix") { inherit pkgs config lib; };

  USER = "david";
  HOME = "/Users/${USER}";

in {

  imports = [ <home-manager/nix-darwin> ];

  nixpkgs.overlays = [
    (
      self: super: {
        # https://github.com/NixOS/nixpkgs/issues/127982
        awscli2 = (
          import (
            builtins.fetchTarball {
              url =
                "https://github.com/NixOS/nixpkgs/archive/a81163d83b6ede70aa2d5edd8ba60062ed4eec74.tar.gz";
              sha256 = "0xwi0m97xgl0x38kf9qq8m3ismcd7zajsmb82brfcxw0i2bm3jyl";
            }
          ) { config = { allowUnfree = true; }; }
        ).awscli2;
      }
    )
  ];

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "DejaVuSansMono"
          "Hack"
          "IBMPlexMono"
        ];
      })
    ];
  };

  system.defaults = {
    dock = {
      autohide = true;        # Autohide Dock
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

  home-manager = {
    users."${USER}" = { pkgs, ... } :{

      programs.home-manager.enable = true;

      imports = [
        base git tmux
        bash zsh nushell
        starship neovim emacs
        alacritty
      ];

      home = {
        stateVersion = "20.09";

        username      = USER;
        homeDirectory = HOME;

        packages = lib.lists.concatMap (mod: mod.packages) [
          cloudPlatforms
          beam
          ruby
          rust
          python
          nodejs
          dhall
          lorri
        ] ++ [
          pkgs.lorri
        ];

        sessionVariables = {
          PAGER  = "less -R";
          EDITOR = "nvim";
          VISUAL = "nvim";
          TERM   = "xterm-256color";

          XDG_CONFIG_HOME = "${HOME}/.config";
          XDG_DATA_HOME   = "${HOME}/.local/share";
          XDG_DATA_DIRS   = "${HOME}/.local/data";
          XDG_RUNTIME_DIR = "${HOME}/.local/run";

          # TODO: Refactor
          FZF_DEFAULT_COMMAND = "fd --type f";
          BAT_CONFIG_PATH     = "${HOME}/.config/bat/config";
          GOPATH              = "${HOME}/Developer/go/";
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

        #file."${HOME}/Library/Application Support/org.nushell.nu/config.toml".source =
        #  "${HOME}/.config/nu/config.toml";

      };
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    #pkgs.home-manager.home-manager
    pkgs.alacritty
    (
      let
        neuronSrc = builtins.fetchTarball "https://github.com/srid/neuron/archive/master.tar.gz";
        neuronPkg = import neuronSrc;
      in neuronPkg.default
    )
  ];

  environment.systemPath = [
     ''/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin''
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/system/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/system/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  services = {
    lorri.enable = true;
  };

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
