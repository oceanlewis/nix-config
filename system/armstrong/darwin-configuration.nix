{ config, pkgs, lib, ... }:

let

  HOST_NAME = "Armstrong";
  USER = "david.lewis";
  HOME = "/Users/${USER}";

in
{
  nix.package = pkgs.nixUnstable;
  nixpkgs.config.allowUnfree = true;

  networking = {
    computerName = HOST_NAME;
    hostName = HOST_NAME;
  };

  fonts = {
    enableFontDir = true;
    fonts = import ../../layers/fonts.nix { inherit pkgs; };
  };

  users.users."${USER}" = {
    home = HOME;
    isHidden = false;
    shell = pkgs.zsh;
  };

  environment = {
    # Append paths to the system PATH
    #systemPath = [
    #  ''/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin''
    #];

    systemPackages = with pkgs; [
      vscode
    ];
  };

  services = {
    nix-daemon.enable = true;
    lorri.enable = true;

    redis = {
      enable = true;
      dataDir = "${HOME}~/.redis";
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
