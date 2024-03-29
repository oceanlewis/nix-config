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

# Start a Zellij session to make quick edits
edit: && _cleanup
	@zellij --layout=zellij-layout.kdl attach System --create --force-run-commands

_cleanup:
	@zellij delete-session --force System
