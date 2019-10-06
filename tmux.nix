{ config, lib, pkgs, ... }:

with lib;

let
  inherit (pkgs) stdenv;
  config = builtins.readFile ./config/tmux.conf;
in

{
  programs.tmux = if stdenv.isDarwin then {
    enable = true;
    tmuxConfig = config + ''
        bind-key -T copy-mode Enter send-keys -X copy-pipe-and-cancel "${pkgs.reattach-to-user-namespace}/bin/reattach-to-user-namespace pbcopy"
      '';
  } else {
    enable = true;
    extraTmuxConf = config + ''
        bind-key -T copy-mode Enter send-keys -X copy-selection-and-cancel
      '';
  };
}