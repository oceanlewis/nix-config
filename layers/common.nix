{ pkgs, lib, ... }:

with pkgs; let

  packages = [
    # Files & Text
    file
    exa
    fd
    ripgrep
    sd # grex
    fzf
    zoxide
    bat
    jq
    yq-go
    mdcat
    icdiff
    tokei
    entr
    pv
    wget
    rsync
    unzip

    # Shells and Unix Environment
    bashInteractive
    elvish
    fish
    (pkgs.callPackage ../packages/dingus.nix { })
    (pkgs.callPackage ../packages/itm.nix { })

    # Chat & Browsing
    irssi
    w3m

    # Identity Management
    gnupg

    ## Writing Tools
    mdbook

    # Process Management
    killall
    htop
    procs
    bandwhich
    bottom

    # Device Management
    smartmontools

    # Networking
    nmap
    httpie
    telnet

    # Content
    youtube-dl

    # Build Tools
    autoconf
    pkg-config
    gnumake

    # Languages
    go
    gopls

    # Nix
    niv
    nixpkgs-fmt
    rnix-lsp
  ]
  ++ lib.optionals pkgs.stdenv.isLinux [
    xsel # rmesg
    xclip
    usbutils # lsusb and others
  ];

  shell.aliases = {
    # Exa
    ls = "exa";
    ll = "exa -l";
    er = "clear; ls -lg";
    r = "clear; ls";
    e = "clear";
    era = "clear; ls -la";
    err = "clear; ls -lR";
    erra = "clear; ls -lRa";
    et = "clear; ls -TL 1";
    eta = "clear; ls -aTL 1";
    et2 = "clear; ls -TL 2";
    et3 = "clear; ls -TL 3";
    et4 = "clear; ls -TL 4";
    etr = "clear; ls -T";
    re = "clear; ls *";
    rea = "clear; ls -a *";

    # Git
    eg = "clear; git status";
    egg = "clear; git status; echo; git diff";
    egc = "clear; git status; echo; git diff --cached";

    # Tmux
    te = "tmux list-sessions";
    ta = "tmux attach";

    theme = "alacritty-theme";
    tf = "terraform";

    zvi = ''nvim "$(fzf)"'';
  }
  // lib.optionalAttrs stdenv.isLinux {
    open = "xdg-open";
    cdcopy = "pwd | xsel -ib";
    cdpaste = "cd \"$(xsel -ob)\"";
  }
  // lib.optionalAttrs stdenv.isDarwin {
    cdcopy = "pwd | pbcopy";
    cdpaste = "cd \"$(pbpaste)\"";
  };

  shell.init = ''
    function purge_docker() {
      docker system prune --force
      docker volume prune --force
      docker image prune --force
      docker container prune --force
    }

    if test -x "$(which direnv)"; then
      eval "$(direnv hook $SHELL)"
    fi
  ''
  +
  lib.optionalString stdenv.isLinux ''
    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
  ''
  +
  lib.optionalString stdenv.isDarwin ''
    export PATH="$HOME/.cargo/bin:$PATH"

    export TMUX_TMPDIR=$XDG_RUNTIME_DIR

    if ! test -d $TMUX_TMPDIR; then
      mkdir -p $TMUX_TMPDIR
    fi

    if [ "$(uname)" = "Darwin" -a -n "$NIX_LINK" -a -f $NIX_LINK/etc/X11/fonts.conf ]; then
      export FONTCONFIG_FILE=$NIX_LINK/etc/X11/fonts.conf
    fi
  '';

in
{

  home.packages = packages;

  home.file.".config/bat/config".text = ''
    --theme="${theme.bat.theme}"
  '';

  # Program Definition
  # - https://github.com/rycee/home-manager/blob/master/modules/programs/zsh.nix
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = shell.aliases;
    initExtra = ''
      set -o vi

      ${shell.init}
      unset RPS1

      if test -x "$(which zoxide)"; then
        eval "$(zoxide init zsh)"
      fi
    '';

    defaultKeymap = "viins";

    oh-my-zsh = {
      enable = true;
      plugins = [
        "vi-mode"
        "history-substring-search"
      ];
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = shell.aliases;
    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
    historyIgnore = [ "ls" "cd" "exit" ];

    initExtra = ''
      set -o vi

      if test -x "$(which zoxide)"; then
        eval "$(zoxide init bash)"
      fi

      ${shell.init}
    '';
  };
}
