{ config, pkgs, lib, ... }:

let

  HOST_NAME = "Armstrong";
  USER = "david.lewis";
  HOME = "/Users/${USER}";

in
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    extraOptions = ''
      # Remote Linux Builder
      extra-trusted-users = david.lewis
      builders = ssh-ng://builder@localhost aarch64-linux /etc/nix/builder_ed25519 4 - - - c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUpCV2N4Yi9CbGFxdDFhdU90RStGOFFVV3JVb3RpQzVxQkorVXVFV2RWQ2Igcm9vdEBuaXhvcwo=
      builders-use-substitutes = true
    '';
  };

  nix.settings = {
    build-users-group = "nixbld";
    experimental-features = "nix-command flakes";
    extra-platforms = "x86_64-darwin aarch64-darwin";
  };

  networking = {
    computerName = HOST_NAME;
    hostName = HOST_NAME;
  };

  fonts = {
    fontDir.enable = true;
    fonts = import ../../layers/fonts.nix { inherit pkgs; };
  };

  users.users."${USER}" = {
    home = HOME;
    isHidden = false;
    shell = pkgs.zsh;
  };

  environment = {
    systemPackages = with pkgs; [ unixODBC ];
    shellAliases = { };
    variables = {
      DYLD_LIBRARY_PATH = "${pkgs.unixODBC}/lib";
    };

    interactiveShellInit = ''
      source ~/.zprofile
    '';
  };

  services = {
    nix-daemon.enable = true;
    lorri.enable = true;

    redis = {
      enable = false;
      dataDir = "${HOME}/.redis";
    };

    postgresql = {
      enable = true;
      package = pkgs.postgresql_14;
      dataDir = "${HOME}/.postgresql_14";
    };
  };

  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
