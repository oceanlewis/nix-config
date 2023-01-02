{
  description = "Darwin Configuration for Armstrong";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , darwin
    , home-manager
    , nixpkgs
    }:
    let
      overlays = [ ];
    in
    {
      darwinConfigurations = {
        inherit overlays;

        Armstrong = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          modules = [
            ./system/armstrong/darwin-configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.users."david.lewis" = import ./system/armstrong/home.nix {
                pkgs = import nixpkgs {
                  inherit overlays system;
                  config.allowUnfree = true;
                };
              };
            }
          ];
        };
      };
    };
}
