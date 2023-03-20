{ pkgs, lib, ... }:

with pkgs; let

  inherit (pkgs) stdenv;
  inherit (stdenv) isDarwin isLinux;

  packages = [
    # Files & Text
    felix-fm
    chafa # required for felix-fm file previews
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
    vivid
    dua
    duf
    du-dust

    # Multimedia
    ffmpeg

    # Shells and Unix Environment
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
    # See https://github.com/NixOS/nixpkgs/issues/175875
    # httpie
    inetutils

    # Content
    yt-dlp
    youtube-dl

    # Build Tools
    autoconf
    pkg-config
    gnumake
    just

    # Languages
    exercism

    # Nix
    nixpkgs-fmt
    rnix-lsp
    nix-tree
  ]
  ++ lib.optionals isLinux [
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


  shellFor = program: {
    sessionVariables = {
      CARGO_TARGET_DIR = "$HOME/.cargo/target";
    } // lib.optional isLinux {
      PATH = "$HOME/.local/bin:$HOME/.cargo/bin:$PATH";
    } // lib.optional isDarwin {
      PATH = "$HOME/.cargo/bin:$PATH";
      TMUX_TMPDIR = "$XDG_RUNTIME_DIR";
    };

    init = ''
      set -o vi

      function purge_docker() {
        docker system prune --force
        docker volume prune --force
        docker image prune --force
        docker container prune --force
      }

      if test -x "$(which direnv)"; then
        eval "$(direnv hook ${program})"
      fi

      if test -x "$(which zoxide)"; then
        eval "$(zoxide init ${program})"
      fi
    ''
    +
    lib.optionalString isDarwin ''
      if ! test -d $TMUX_TMPDIR; then
        mkdir -p $TMUX_TMPDIR
      fi

      if [ "$(uname)" = "Darwin" -a -n "$NIX_LINK" -a -f $NIX_LINK/etc/X11/fonts.conf ]; then
        export FONTCONFIG_FILE=$NIX_LINK/etc/X11/fonts.conf
      fi
    '';

    aliases = {
      # Git
      eg = "clear; git status";
      egg = "clear; git status; echo; git diff";
      egc = "clear; git status; echo; git diff --cached";

      # Tmux
      te = "tmux list-sessions";
      ta = "tmux attach";

      tf = "terraform";

      zvi = ''nvim $(fzf --preview 'bat --style=numbers --color=always {}')'';
      zhx = ''hx $(fzf --preview 'bat --style=numbers --color=always {}')'';
    } //
    lsdAliases //
    lib.optionalAttrs isLinux {
      open = "xdg-open";
      cdcopy = "pwd | xsel -ib";
      cdpaste = "cd \"$(xsel -ob)\"";
    } //
    lib.optionalAttrs isDarwin {
      cdcopy = "pwd | pbcopy";
      cdpaste = "cd \"$(pbpaste)\"";
    };
  };

in
{
  home.packages = packages;

  home.file.".config/bat/config".text = lib.optionalString (theme.bat != null) ''
    --theme="${theme.bat}" --plain
  '';

  home.file.".config/vivid/theme".text = lib.optionalString (theme.vivid != null) ''
    ${theme.vivid}
  '';

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Program Definition
  # - https://github.com/rycee/home-manager/blob/master/modules/programs/zsh.nix
  programs.zsh = let shell = shellFor "zsh"; in
    {
      enable = true;
      dotDir = ".config/zsh";
      shellAliases = shell.aliases;
      initExtra = ''
        unset RPS1
        function custom_preexec () {
          if test -x "$(which vivid)"; then
            export LS_COLORS=$(vivid generate $(cat ~/.config/vivid/theme))
          fi
        }
        add-zsh-hook preexec custom_preexec

        ${shell.init}
      '';

      defaultKeymap = "viins";

      oh-my-zsh = {
        enable = true;
        plugins = [ "vi-mode" "history-substring-search" ];
      };
    };

  programs.bash = let shell = shellFor "bash"; in
    {
      enable = false;
      shellAliases = shell.aliases;
      historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
      historyIgnore = [ "ls" "cd" "exit" ];
      initExtra = shell.init;
    };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };
}
