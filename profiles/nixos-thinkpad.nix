{ pkgs, config, lib, ... }:

let

  theme = import ../layers/theme.nix {
    inherit pkgs;
    theme      = "gruvbox";
    variant    = "dark";
    fontFamily = "Fira Code";
    fontSize   = 12;
  };


  git = import ../programs/git/git.nix { inherit pkgs config lib theme; };
  alacritty = import ../programs/alacritty.nix { inherit pkgs config lib theme; };
  emacs = import ../programs/emacs.nix { inherit pkgs; };
  zsh = import ../programs/zsh.nix { inherit pkgs shell; };
  bash = import ../programs/bash.nix { inherit pkgs shell; };
  nushell = import ../programs/nushell.nix { inherit pkgs; };
  tmux = import ../programs/tmux.nix { inherit pkgs config lib; };
  starship = import ../programs/starship.nix { inherit pkgs config lib; };

  neovim = import ../programs/neovim.nix {
    inherit pkgs config lib theme;
    extraPlugins = (dhall.vimPlugins ++ ruby.vimPlugins ++ python.vimPlugins ++ rust.vimPlugins);
  };

  shell = import ../layers/posix-shell.nix { inherit pkgs; };
  base = import ../layers/base.nix { inherit pkgs lib; };
  cloudPlatforms = import ../layers/cloud-platforms.nix { inherit pkgs; };
  beam = import ../layers/beam.nix { inherit pkgs; };
  ruby = import ../layers/ruby.nix { inherit pkgs; };
  rust = import ../layers/rust.nix { inherit pkgs; };
  python = import ../layers/python.nix { inherit pkgs; };
  nodejs = import ../layers/nodejs.nix { inherit pkgs; };
  dhall = import ../layers/dhall.nix { inherit pkgs; };
  lorri = import ../services/lorri.nix { inherit pkgs config lib; };

  USER = "david";
  HOME = "/home/${USER}";

in

{

  programs = {
    home-manager.enable = true;
    man.enable = false;
  };

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
    lorri.home
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
      lorri.packages ++ [
        pkgs.ion
      ];

    sessionVariables = {
      PAGER  = "less -R";
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERM   = "xterm-256color";

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

  };

}
