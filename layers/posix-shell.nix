{ pkgs }:

let

  default = {

    aliases = {
      # Exa
      ls   = "exa";
      ll   = "exa -l";
      er   = "clear; ls -lg";
      r    = "clear; ls";
      e    = "clear";
      era  = "clear; ls -la";
      err  = "clear; ls -lR";
      erra = "clear; ls -lRa";
      et   = "clear; ls -TL 1";
      eta  = "clear; ls -aTL 1";
      et2  = "clear; ls -TL 2";
      et3  = "clear; ls -TL 3";
      et4  = "clear; ls -TL 4";
      etr  = "clear; ls -T";
      re   = "clear; ls *";
      rea  = "clear; ls -a *";

      # Git
      eg  = "clear; git status";
      egg = "clear; git status; echo; git diff";
      egc = "clear; git status; echo; git diff --cached";

      # Tmux
      te = "tmux list-sessions";
      ta = "tmux attach";

      # Bat
      bat = "bat -p";
      dat = "bat -p --theme Dracula";
      lat = "bat -p --theme GitHub";

      # Ytop
      ltop = "ytop -c default-dark";
      dtop = "ytop -c monokai";

      theme = "alacritty-theme";
      tf = "terraform";
    };

    initExtra = ''
      export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

      # Initialize Nix Profile
      . $HOME/.nix-profile/etc/profile.d/nix.sh

      function purge_docker() {
        docker system prune --force
        docker volume prune --force
        docker image prune --force
        docker container prune --force
      }
    '';

  };

  linux = {

    aliases = {
      open    = "xdg-open";
      cdcopy  = "pwd | xsel -ib";
      cdpaste = "cd \"$(xsel -ob)\"";
    };

    initExtra = ''
      function update() {
        local origDir=$(pwd)

        sudo apt update && \
        sudo apt upgrade && \
        flatpak update && \
        cd $HOME/.config/nixpkgs && make upgrade && cd $origDir
      }
    '';

  };

  darwin = {

    aliases = {
      cdcopy  = "pwd | pbcopy";
      cdpaste = "cd \"$(pbpaste)\"";
    };

    initExtra = ''
      export TMUX_TMPDIR=$XDG_RUNTIME_DIR

      if ! test -d $TMUX_TMPDIR; then
        mkdir -p $TMUX_TMPDIR
      fi
    '';

  };

in

{

  aliases =
    default.aliases // (
      if      pkgs.stdenv.isLinux  then linux.aliases
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
