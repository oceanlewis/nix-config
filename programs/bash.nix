{ config, lib, pkgs, ... }:

let

  aliases = {
    exa = {
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
    };

    git = {
      eg  = "clear; git status";
      egg = "clear; git status; echo; git diff";
      egc = "clear; git status; echo; git diff --cached";
    };

    tmux = {
      te = "tmux list-sessions";
      ta = "tmux attach";
    };

    bat = {
      bat = "bat -p";
      dat = "bat -p --theme Dracula";
      lat = "bat -p --theme GitHub";
    };

    ytop = {
      ltop = "ytop -c default-dark";
      dtop = "ytop -c monokai";
    };

    linux = {
      open    = "xdg-open";
      cdcopy  = "pwd | xsel -ib";
      cdpaste = "cd \"$(xsel -ob)\"";
    };
  };

  platformSpecific = if pkgs.stdenv.isLinux then aliases.linux else {};

in

{
  programs.bash = {
    enable = true;

    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
    historyIgnore  = [ "ls" "cd" "exit" ];

    shellAliases = {
      ".." = "cd ..";
      theme = "alacritty-theme";
      tf = "terraform";
    }
    // aliases.exa // aliases.git // aliases.tmux // aliases.bat // aliases.ytop
    // platformSpecific;

    initExtra = ''
      export PATH="$HOME/.local/bin/:$HOME/.cargo/bin:$PATH"

      . $HOME/.nix-profile/etc/profile.d/nix.sh
    '';
  };
}
