{ pkgs, config, lib, ... }:

let

  theme = import ../layers/theme.nix {
    inherit pkgs;
    theme      = "gruvbox";
    variant    = "dark";
    fontFamily = "SF Mono";
    fontSize   = 13.5;
  };

  base = import ../layers/base.nix {
    inherit pkgs lib;
  };

  cloudPlatforms = import ../layers/cloud-platforms.nix {
    inherit pkgs;
  };

  beam = import ../layers/beam.nix {
    inherit pkgs;
  };

  ruby = import ../layers/ruby.nix {
    inherit pkgs;
  };

  rust = import ../layers/rust.nix { inherit pkgs; };

  python = import ../layers/python.nix {
    inherit pkgs;
  };

  nodejs = import ../layers/nodejs.nix {
    inherit pkgs;
  };

  dhall = import ../layers/dhall.nix {
    inherit pkgs;
  };

  git = import ../programs/git/git.nix {
    inherit pkgs config lib theme;
  };

  alacritty = import ../programs/alacritty.nix {
    inherit pkgs config lib theme;
  };

  neovim = import ../programs/neovim.nix {
    inherit pkgs config lib theme;
    extraPlugins = lib.concatLists([
      dhall.vimPlugins
      ruby.vimPlugins
      python.vimPlugins
      rust.vimPlugins
    ]);
  };

  emacs = import ../programs/emacs.nix {
    inherit pkgs;
  };

  shell = import ../layers/posix-shell.nix {
    inherit pkgs;
  };

  zsh = import ../programs/zsh.nix {
    inherit pkgs shell;
  };

  bash = import ../programs/bash.nix {
    inherit pkgs shell;
  };

  nushell = import ../programs/nushell.nix {
    inherit pkgs;
  };

  tmux = import ../programs/tmux.nix {
    inherit pkgs config lib;
  };

  starship = import ../programs/starship.nix {
    inherit pkgs config lib;
  };

  lorri = import ../services/lorri.nix {
    inherit pkgs config lib;
  };

  USER = "davidlewis";
  HOME = "/Users/${USER}";

in

{

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

    packages =
      cloudPlatforms.packages ++
      beam.packages ++
      ruby.packages ++
      rust.packages ++
      python.packages ++
      nodejs.packages ++
      dhall.packages ++
      bash.packages ++
      lorri.packages ++ (with pkgs; [
        lorri
        neuron-notes
      ]);

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

}
