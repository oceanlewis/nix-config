install-nixpkgs:
	curl -L https://nixos.org/nix/install | sh

install-home-manager:
	nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install

init: install-nixpkgs install-home-manager

print-bold = (echo "\n\033[1m$1\033[0m")

collect-garbage:
	@$(call print-bold,"Collecting Garbage...")
	@nix-collect-garbage -d

upgrade:
	@$(call print-bold,"Upgrading Nix...")
	@nix upgrade-nix

	@$(call print-bold,"Updating Nix Channels...")
	@nix-channel --update

	@$(call print-bold,"Upgrading Nix Environment...")
	@nix-env --upgrade

	@$(call print-bold,"Activating new Home Manager Generation...")
	@home-manager switch

switch:
ifdef profile
		@$(call print-bold,"Attempting to link Home Manager Profile ($(profile))...")
		@ln -fs ./machines/$(profile).nix ./home.nix
endif
	@$(call print-bold,"Activating Home Manager Profile...")
	@home-manager switch
