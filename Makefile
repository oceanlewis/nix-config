install-nixpkgs:
	curl -L https://nixos.org/nix/install | sh

install-home-manager:
	nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install

init: install-nixpkgs install-home-manager

update-nix-channels:
	@echo "Updating Nix Channels..."
	nix-channel --update
	@echo "Done.\n"

upgrade-nix:
	@echo "Upgrading Nix..."
	@nix upgrade-nix
	@echo "Done.\n"

upgrade-nix-env:
	@echo "Upgrading Nix Environment..."
	@nix-env --upgrade
	@echo "Done."

home-manager-switch:
	@echo "Activating new Home Manager Generation..."
	@home-manager switch
	@echo "Done."

upgrade: update-nix-channels upgrade-nix upgrade-nix-env home-manager-switch

collect-garbage:
	nix-collect-garbage -d

switch:
	@ln -fs ./machines/${profile}.nix ./home.nix
	@home-manager switch
