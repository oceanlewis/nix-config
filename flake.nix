{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-22.11";
    zjstatus.url = "github:dj95/zjstatus";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager-nixos = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixos-stable";
    };
    home-manager-master = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    inputs@{ self
    , home-manager-master
    , home-manager-nixos
    , nixpkgs-unstable
    , nixos-stable
    , darwin
    , flake-utils
    , zjstatus
    }:
    let
      overlays = [
        (final: prev: {
          zjstatus = zjstatus.packages.${prev.system}.default;
        })
        (import overlay/vimPlugins.nix)
      ];
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };

      nixosSystem-stable = nixos-stable.lib.nixosSystem;
      darwinSystem = darwin.lib.darwinSystem;
    in
    flake-utils.lib.eachDefaultSystem
      (system: {
        devShells.default = import ./shell.nix {
          pkgs =
            if builtins.elem system [ "aarch64-darwin" "x86_64-darwin" ]
            then import nixpkgs-unstable { inherit overlays system config; }
            else import nixos-stable { inherit overlays system config; };
        };
      })
    //
    {
      nixosConfigurations.ghastly = nixosSystem-stable rec {
        system = "aarch64-linux";
        modules = [
          ./host/ghastly/configuration.nix
          home-manager-nixos.nixosModules.home-manager
          {
            home-manager.users.ocean = import ./home/console-user.nix {
              pkgs = import nixos-stable { inherit overlays system config; };
              config = {
                user = "ocean";
                home = "/home/ocean";
                state_version = "22.11";
              };
              theme-config.helix = "base16_transparent";
            };
          }
        ];
      };

      darwinConfigurations.armstrong = darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs;
          overlays = overlays ++ [
            (import overlay/theme {
              name = "standard";
              variant = "light";
              font.monospace = "Menlo";
            })
          ];
        };
        modules = [
          ./host/armstrong/darwin-configuration.nix
          home-manager-master.darwinModules.home-manager
          {
            nixpkgs.config = config;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."ocean.lewis" =
              import ./home/darwin-user.nix {
                username = "ocean.lewis";
                homeDirectory = "/Users/ocean.lewis";
                stateVersion = "22.11";
              };
          }
        ];
      };
    };
}        
