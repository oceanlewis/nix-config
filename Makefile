install-nixpkgs:
	curl -L https://nixos.org/nix/install | sh

install-home-manager:
	nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install

init: install-nixpkgs install-home-manager

print-bold = (echo "\n\033[1m$1\033[0m")

collect-garbage:
	@echo "\nCollecting Garbage..."
	@nix-collect-garbage -d

upgrade:
	@echo "\nUpgrading Nix..."
	@nix upgrade-nix

	@echo "\nUpdating Nix Channels..."
	@nix-channel --update

	@echo "\nUpgrading Nix Environment..."
	@nix-env --upgrade

	@echo "\nActivating new Home Manager Generation..."
	@home-manager switch

switch:
ifdef profile
		@echo "\nAttempting to link Home Manager Profile $(profile)..."
		@ln -fs ./profiles/$(profile).nix ./home.nix
endif
	@echo "\nActivating Home Manager Profile..."
	@home-manager switch
