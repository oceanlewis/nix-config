install-nix:
	curl -L https://nixos.org/nix/install | sh

update:
	@echo "\nUpdating Nix Flakes..."
	@nix flake --update

wizard:
	@darwin-rebuild switch

armstrong:
	@darwin-rebuild switch --flake .#armstrong

ghastly:
	@sudo nixos-rebuild switch --flake .#ghastly

