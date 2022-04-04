{ pkgs, lib, ... }:

with pkgs; let

  packages = [
    # Files & Text
    file
    exa
    fd
    ripgrep
    sd
    grex
    fzf
    zoxide
    bat
    jq
    yq-go
    mdcat
    glow
    icdiff
    tokei
    entr
    fswatch
    pv
    wget
    rsync
    unzip

    # Multimedia
    ffmpeg

    # Shells and Unix Environment
    #bashInteractive
    (pkgs.callPackage ../packages/dingus.nix { })
    (pkgs.callPackage ../packages/itm { })

    # Chat & Browsing
    # irssi
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
    inetutils

    # Content
    youtube-dl

    # Build Tools
    autoconf
    pkg-config
    gnumake

    # Languages
    exercism

    # Nix
    # niv
    direnv
    nixpkgs-fmt
    rnix-lsp
  ]
  ++ lib.optionals pkgs.stdenv.isLinux [
    xsel # rmesg
    xclip
    usbutils # lsusb and others
  ];

  exaAliases = {
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
  };

  lsdAliases = {
    er = "clear; ls -l";
    r = "clear; ls";
    e = "clear";
    era = "clear; ls -la";
    err = "clear; ls -lR";
    erra = "clear; ls -lRa";
    et = "clear; ls --tree --depth 1";
    eta = "clear; ls -a --tree --depth 1";
    et2 = "clear; ls --tree --depth 2";
    et3 = "clear; ls --tree --depth 3";
    et4 = "clear; ls --tree --depth 4";
    etr = "clear; ls --tree";
    re = "clear; ls *";
    rea = "clear; ls -a *";
  };

  shell.aliases = {
    # Git
    eg = "clear; git status";
    egg = "clear; git status; echo; git diff";
    egc = "clear; git status; echo; git diff --cached";

    # Tmux
    te = "tmux list-sessions";
    ta = "tmux attach";

    tf = "terraform";

    zvi = ''nvim "$(fzf)"'';
  } //
  lsdAliases //
  lib.optionalAttrs stdenv.isLinux {
    open = "xdg-open";
    cdcopy = "pwd | xsel -ib";
    cdpaste = "cd \"$(xsel -ob)\"";
  } //
  lib.optionalAttrs stdenv.isDarwin {
    cdcopy = "pwd | pbcopy";
    cdpaste = "cd \"$(pbpaste)\"";
  };

  shell.init = shell: ''
    function purge_docker() {
      docker system prune --force
      docker volume prune --force
      docker image prune --force
      docker container prune --force
    }

    if test -x "$(which direnv)"; then
      eval "$(direnv hook ${shell})"
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

      ${shell.init "zsh"}
      unset RPS1

      if test -x "$(which zoxide)"; then
        eval "$(zoxide init zsh)"
      fi
    '';

    defaultKeymap = "viins";

    oh-my-zsh = {
      enable = true;
      plugins = [ "vi-mode" "history-substring-search" ];
    };
  };

  programs.bash = {
    enable = false;
    shellAliases = shell.aliases;
    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
    historyIgnore = [ "ls" "cd" "exit" ];

    initExtra = ''
      set -o vi

      if test -x "$(which zoxide)"; then
        eval "$(zoxide init bash)"
      fi

      ${shell.init "bash"}
    '';
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
    settings = { color.when = "never"; };
  };
}
