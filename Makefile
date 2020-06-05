install-nixpkgs:
	curl -L https://nixos.org/nix/install | sh

install-home-manager:
	nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install

init: install-nixpkgs install-home-manager

upgrade:
	@echo "Updating Nix Channels..."
	nix-channel --update
	@echo "Done.\n"
	@echo "Upgrading Nix..."
	@nix upgrade-nix
	@echo "Done.\n"
	@echo "Upgrading Nix Environment..."
	@nix-env --upgrade
	@echo "Done."
