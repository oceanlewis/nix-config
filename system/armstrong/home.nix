{ pkgs, ... }:

let

  HOST_NAME = "Armstrong";
  USER = "david.lewis";
  HOME = "/Users/${USER}";

in
{

  nixpkgs.overlays = pkgs.overlays ++ [
    (import ../../overlays/theme)
    (import ../../overlays/ipython.nix)
    (import ../../overlays/vimPlugins.nix)
  ];

  imports = [
    ../../layers/common.nix
    ../../programs/nushell
    ../../programs/tmux.nix
    ../../programs/starship.nix
    ../../programs/git
    # ../../programs/neovim
    ../../programs/alacritty
    ../../programs/helix
    ../../programs/zellij
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "21.11";
    username = USER;
    homeDirectory = HOME;

    sessionVariables = {
      PAGER = "less -R";
      EDITOR = "hx";
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

    # file."${HOME}/.config/nu/config.toml".onChange = ''
    #   echo Linking in nushell config file
    #   ln -sfv "${HOME}/.config/nu/config.toml" "${HOME}/Library/Application Support/org.nushell.nu/config.toml"
    # '';
  };

}
