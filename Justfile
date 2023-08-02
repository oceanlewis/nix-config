default:
	@just --list

# Download and start a NixOS builder container
darwin-builder:
	nix run nixpkgs#darwin.builder

# Update flake.lock
update:
	nix flake update

# Armstrong's nix-darwin rebuild command
armstrong:
	darwin-rebuild switch --flake .#armstrong

wizard:
	darwin-rebuild witch --flake .#armstrong

ghastly:
	sudo nixos-rebuild switch --flake .#ghastly
