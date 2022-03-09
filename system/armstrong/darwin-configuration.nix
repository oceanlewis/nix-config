{ config, pkgs, lib, ... }:

let

  HOST_NAME = "Armstrong";
  USER = "david.lewis";
  HOME = "/Users/${USER}";

in
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixUnstable;
    useSandbox = false;
  };

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
      #vscode
    ];

    shellAliases = {
      #gimme-snowflake-creds = "docker run -it --rm -v ~/.okta_snowflake_login_config:/root/.okta_snowflake_login_config -v ~/.dbt:/root/.dbt -v ~/Library/ODBC:/root/Library/ODBC -v ~/.gsc:/root/.gsc hgdata1/gimme-snowflake-creds";
      gimme-aws-creds = "docker run -it --rm -v ~/.aws/credentials:/root/.aws/credentials -v ~/.okta_aws_login_config:/root/.okta_aws_login_config hgdata1/gimme-aws-creds";
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
      enable = false;
      package = pkgs.postgresql_14;
      dataDir = "${HOME}/.postgresql_14";
    };
  };

  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
