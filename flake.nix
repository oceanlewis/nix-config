{
  inputs = {
    flake-utils.url = github:numtide/flake-utils;
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-22.11";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager-nixos = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager-master = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    { self
    , flake-utils
    , darwin
    , home-manager-master
    , home-manager-nixos
    , nixpkgs-unstable
    , nixos-stable
    }:
    let overlays = [ ];
    in
    flake-utils.lib.eachDefaultSystem
      (system: {
        devShells.default = import ./shell.nix {
          pkgs =
            if builtins.elem system [ "aarch64-darwin" "x86_64-darwin" ]
            then import nixpkgs-unstable { inherit overlays system; }
            else import nixos-stable { inherit overlays system; };
        };
      })
    //
    {
      nixosConfigurations.ghastly = nixos-stable.lib.nixosSystem rec {
        system = "aarch64-linux";
        modules = [
          ./system/ghastly/configuration.nix
          home-manager-nixos.nixosModules.home-manager
          {
            home-manager.users.david = import ./home/console_user.nix {
              pkgs = import nixos-stable { inherit overlays system; };
              config = {
                user = "david";
                theme.helix = "base16_transparent";
                home.state_version = "22.11";
              };
            };
          }
        ];
      };

      darwinConfigurations.armstrong = darwin.lib.darwinSystem rec {
        system = "aarch64-darwin";
        modules = [
          ./system/armstrong/darwin-configuration.nix
          home-manager-master.darwinModules.home-manager
          {
            home-manager.users."david.lewis" = import ./system/armstrong/home.nix {
              pkgs = import nixpkgs-unstable {
                inherit overlays system;
                config.allowUnfree = true;
              };
            };
          }
        ];
      };
    };
}        
