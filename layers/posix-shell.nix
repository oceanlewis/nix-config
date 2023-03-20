{ pkgs }:

let

  lib = pkgs.lib;
  isNixOS = builtins.pathExists "/etc/NIXOS";

  default = {

    aliases = {
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
    };

    initExtra = (
      lib.optionalString (!isNixOS)
        ''
          # Initialize Nix Profile
          . $HOME/.nix-profile/etc/profile.d/nix.sh
        ''
    ) + ''
      function purge_docker() {
        docker system prune --force
        docker volume prune --force
        docker image prune --force
        docker container prune --force
      }

      if test -x "$(which direnv)"; then
        eval "$(direnv hook $SHELL)"
      fi
    '';

  };

  linux = {

    aliases = {
      open = "xdg-open";
      cdcopy = "pwd | xsel -ib";
      cdpaste = "cd \"$(xsel -ob)\"";
    };

    initExtra = ''
      export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
      export CARGO_TARGET_DIR="$HOME/.cargo/target"
    '';

  };

  darwin = {

    aliases = {
      cdcopy = "pwd | pbcopy";
      cdpaste = "cd \"$(pbpaste)\"";
    };

    initExtra = ''
      export PATH="$HOME/.cargo/bin:$PATH"

      export TMUX_TMPDIR=$XDG_RUNTIME_DIR

      if ! test -d $TMUX_TMPDIR; then
        mkdir -p $TMUX_TMPDIR
      fi

      if [ "$(uname)" = "Darwin" -a -n "$NIX_LINK" -a -f $NIX_LINK/etc/X11/fonts.conf ]; then
        export FONTCONFIG_FILE=$NIX_LINK/etc/X11/fonts.conf
      fi
    '';

  };

in

{

  aliases = default.aliases // (
    if pkgs.stdenv.isLinux then linux.aliases
    else if pkgs.stdenv.isDarwin then darwin.aliases
    else { }
  );

  initExtra = ''
    ${default.initExtra}
    ${
      if      pkgs.stdenv.isLinux  then linux.initExtra
      else if pkgs.stdenv.isDarwin then darwin.initExtra
      else { }
    }
  '';

}
