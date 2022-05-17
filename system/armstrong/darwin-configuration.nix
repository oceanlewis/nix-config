{ config, pkgs, lib, ... }:

let

  HOST_NAME = "Armstrong";
  USER = "david.lewis";
  HOME = "/Users/${USER}";

in
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      build-users-group = nixbld
      experimental-features = nix-command flakes
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
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
    systemPackages = with pkgs; [ vscode unixODBC ];
    shellAliases = { };
    variables = {
      DYLD_LIBRARY_PATH = "${pkgs.unixODBC}/lib";
    };
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
