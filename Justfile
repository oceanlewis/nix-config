default:
	@just --list

# Download and start a NixOS builder container
darwin-builder:
	nix run nixpkgs#darwin.builder

# Update flake.lock
update:
	nix flake update

# Runs the `just` target for the current host
apply target=`hostname`:
	just {{target}}

# Start a Zellij session to make quick edits
edit: && _cleanup
	@zellij --layout=zellij-layout.kdl attach System --create --force-run-commands

# Runs the `just` target when file changes are detected
watch:
	fd | entr -pc sh -c 'just apply'

_cleanup:
	@zellij delete-session System

# Armstrong's nix-darwin rebuild command
[private]
Armstrong:
	darwin-rebuild switch --flake .#Armstrong

[private]
ghastly:
	sudo nixos-rebuild switch --flake .#ghastly
