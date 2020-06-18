install-nixpkgs:
	curl -L https://nixos.org/nix/install | sh

install-home-manager:
	nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install

init: install-nixpkgs install-home-manager

update-nix-channels:
	@echo "\033[1mUpdating Nix Channels...\033[0m"
	nix-channel --update
	@echo "Done.\n"

upgrade-nix:
	@echo "\033[1mUpgrading Nix...\033[0m"
	@nix upgrade-nix
	@echo "Done.\n"

upgrade-nix-env:
	@echo "\033[1mUpgrading Nix Environment...\033[0m"
	@nix-env --upgrade
	@echo "Done."

home-manager-switch:
	@echo "\033[1mActivating new Home Manager Generation...\033[0m"
	@home-manager switch
	@echo "Done."

collect-garbage:
	@echo "\033[1mCollecting Garbage...\033[0m"
	@nix-collect-garbage -d

upgrade: upgrade-nix update-nix-channels upgrade-nix-env home-manager-switch

switch:
	@echo "\033[1mActivating Profile: \"${profile}\"...\033[0m"
	@ln -fs ./machines/${profile}.nix ./home.nix
	@home-manager switch
