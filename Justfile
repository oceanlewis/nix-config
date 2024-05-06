default:
	@just --list

# Download and start a NixOS builder container
darwin-builder:
	nix run nixpkgs#darwin.builder

# Update flake.lock
update:
	nix flake update

# Runs the `just` target for the current host
rebuild target=`hostname`:
	just {{target}}

# Armstrong's nix-darwin rebuild command
Armstrong:
	darwin-rebuild switch --flake .#Armstrong

ghastly:
	sudo nixos-rebuild switch --flake .#ghastly

# Start a Zellij session to make quick edits
edit: && _cleanup
	@zellij --layout=zellij-layout.kdl attach System --create --force-run-commands

# Runs the `just` target when file changes are detected
watch:
	fd | entr -pc sh -c 'just rebuild'

_cleanup:
	@zellij delete-session --force System
