{ config, pkgs, lib, ... }:

let

  layer = fileName: builtins.toPath "${HOME}/.config/nixpkgs/layers/${fileName}";
  program = fileName: builtins.toPath "${HOME}/.config/nixpkgs/programs/${fileName}";
  service = fileName: builtins.toPath "${HOME}/.config/nixpkgs/services/${fileName}";

  theme = import (layer "theme.nix") {
    inherit pkgs;
    theme      = "gruvbox";
    variant    = "dark";
    fontFamily = "SF Mono";
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

  USER = "davidlewis";
  HOME = "/Users/${USER}";

in {

  imports = [ <home-manager/nix-darwin> ];

  users.users.davidlewis = {
    home = HOME;
    isHidden = false;
    shell = pkgs.zsh;
  };

  home-manager = {
    users.davidlewis = { pkgs, ... } :{

      programs.home-manager.enable = true;

      imports = [
        base git
        bash.home
        alacritty.home
        emacs.home
        zsh.home
        tmux.home
        starship.home
        nushell.home
        neovim
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
          bash
          lorri
        ] ++ [
          pkgs.lorri
          pkgs.neuron-notes
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
          RUSTC_WRAPPER       = "${HOME}/.nix-profile/bin/sccache";
          FZF_DEFAULT_COMMAND = "fd --type f";
          BAT_CONFIG_PATH     = "${HOME}/.config/bat/config";
        };

        file.".config/nvim/coc-settings.json".text = ''
          {
            "languageserver": {
              "terraform": {
                "command": "terraform-ls",
                "args": ["serve"],
                "filetypes": [
                  "terraform",
                  "tf"
                ],
                "initializationOptions": {},
                "settings": {}
              },
              "nix": {
                "command": "rnix-lsp",
                "filetypes": [
                  "nix"
                ]
              }
            }
          }
        '';

        file.".config/bat/config".text = ''
          --theme="${theme.bat.theme}"
        '';

      };
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    #pkgs.home-manager.home-manager
    pkgs.alacritty
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/systems/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
