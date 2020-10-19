{ pkgs, config, lib, ... }:

let

  theme = import ../layers/theme.nix {
    inherit pkgs;
    theme      = "gruvbox";
    variant    = "light";
    fontFamily = "Hack";
    fontSize   = 13.5;
  };

  base = import ../layers/base.nix {
    inherit pkgs;
  };

  devPackages = import ../layers/dev-packages.nix {
    inherit pkgs;
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

  rust = import ../layers/rust.nix {
    inherit pkgs;
  };

  jvm = import ../layers/jvm.nix {
    inherit pkgs;
  };

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
    extraGitIgnores = jvm.git.ignores ++ [ ".vscode" ];
  };

  alacritty = import ../programs/alacritty.nix {
    inherit pkgs config lib theme;
  };

  neovim = import ../programs/neovim.nix {
    inherit pkgs config lib theme;
    extraPlugins = (
      dhall.vimPlugins ++
      ruby.vimPlugins ++
      python.vimPlugins ++
      rust.vimPlugins
    );
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
    git.home
    bash.home
    alacritty.home
    neovim.home
    emacs.home
    zsh.home
    tmux.home
    starship.home
    nushell.home
  ];

  home = {
    stateVersion = "20.09";

    username      = USER;
    homeDirectory = HOME;

    packages =
      devPackages ++
      base.packages ++
      cloudPlatforms.packages ++
      beam.packages ++
      ruby.packages ++
      rust.packages ++
      jvm.packages ++
      python.packages ++
      nodejs.packages ++
      git.packages ++
      neovim.packages ++
      dhall.packages ++
      bash.packages ++
      lorri.packages ++ [
        pkgs.lorri
      ];

    sessionVariables = {
      PAGER     = "less -R";
      EDITOR    = "nvim";
      VISUAL    = "nvim";
      TERM      = "xterm-256color";

      XDG_CONFIG_HOME = "${HOME}/.config";
      XDG_DATA_HOME   = "${HOME}/.local/share";
      XDG_DATA_DIRS   = "${HOME}/.local/data";
      XDG_RUNTIME_DIR = "${HOME}/.local/run";

      # TODO: Refactor
      RUSTC_WRAPPER       = "${HOME}/.nix-profile/bin/sccache";
      FZF_DEFAULT_COMMAND = "fd --type f";
      GLAMOUR_STYLE       = theme.gh.style;
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

  };

}
