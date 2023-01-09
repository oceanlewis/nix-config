install-nixpkgs:
	curl -L https://nixos.org/nix/install | sh

install-home-manager:
	nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install

install-nix-darwin:
	nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
	./result/bin/darwin-installer
	@echo "NOTE: the system activation scripts don't overwrite existing etc files, so files like /etc/bashrc and /etc/zshrc won't be updated by default. If you didn't use the installer or skipped some of the options you'll have to take care of this yourself. Either modify the existing file to source/import the one from /etc/static or remove it."
	@echo "\n\nIf the installation was successful, it's safe to remove the 'result' directory"

setup-darwin:
	darwin-rebuild switch -I darwin-config=${HOME}/.nixpkgs/darwin-configuration.nix

link-darwin:
	mkdir -p ${HOME}/.nixpkgs
	ln -hf darwin-configuration.nix ~/.nixpkgs/darwin-configuration.nix

uninstall-nix-darwin:
	nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A uninstaller
	./result/bin/darwin-uninstaller

collect-garbage:
	@echo "\nCollecting Garbage..."
	@nix-collect-garbage -d

update:
	@echo "\nUpdating Nix Channels..."
	@nix-channel --update

upgrade:
	@echo "\nUpgrading Nix..."
	@nix upgrade-nix

	@echo "\nUpgrading Nix Environment..."
	@nix-env --upgrade

	@echo "\nActivating new Home Manager Generation..."
	@home-manager switch

darwin:
	@darwin-rebuild switch

armstrong:
	@darwin-rebuild switch --flake .#Armstrong

ghastly:
	@sudo nixos-rebuild switch --flake .#ghastly

switch:
ifdef profile
	@echo -e "\nAttempting to link Home Manager Profile $(profile)..."
	@ln -fs ./profiles/$(profile).nix ./home.nix
endif
	@echo -e "\nActivating Home Manager Profile..."
	@home-manager switch
