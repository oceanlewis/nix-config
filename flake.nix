{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-22.11";
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
    next-ls = {
      url = "github:elixir-tools/next-ls";
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
    , next-ls
    }:
    let
      overlays = [
        (import ./overlay/extraPackages.nix { inherit next-ls; })
      ];
      config = { allowUnfree = true; };

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
          ./system/ghastly/configuration.nix
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

      darwinConfigurations.armstrong = darwinSystem rec {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs overlays; };
        modules = [
          ./system/armstrong/darwin-configuration.nix
          home-manager-master.darwinModules.home-manager
          {
            home-manager.users."ocean.lewis" = import ./home/darwin-user.nix {
              pkgs = import nixpkgs-unstable {
                inherit overlays system config;
              };
              config = {
                user = "ocean.lewis";
                home = "/Users/ocean.lewis";
                state_version = "22.11";
              };
              theme-config = {
                name = "standard";
                variant = "light";
                font.monospace = "JetBrains Mono";
              };
            };
          }
        ];
      };
    };
}        
