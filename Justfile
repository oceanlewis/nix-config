z_session := "nix"

_default:
    @clear -x; just --list

# Download and start a NixOS builder container
darwin-builder:
    nix run nixpkgs#darwin.builder

# Update flake.lock
update:
    nix flake update

dev *recipe:
    nix develop --command just {{ recipe }}

alias rebuild := apply
# Runs the `just` target for the current host
apply target=`hostname`:
    just {{ target }}

# Start a Zellij session to make quick edits
edit: && _cleanup
    @zellij \
    		--config-dir=$HOME/.config/zellij \
    		--layout=zellij-layout.kdl \
    	attach {{ z_session }} \
    		--force-run-commands \
    		--create

_theme host=`hostname`:
    @hx --hsplit \
    	./host/{{ host }}/configuration.nix \
    	./host/{{ host }}/theme.nix:3:14

# Runs the `just` target when file changes are detected
watch:
    @echo "Watching for changes..."
    @fd | entr -pc sh -c 'just apply && echo Done'

_cleanup:
    zellij delete-session {{ z_session }}

[private]
Armstrong:
    sudo darwin-rebuild switch --flake .#Armstrong

[private]
pigeon:
    sudo darwin-rebuild switch --flake .#pigeon

[private]
ghastly:
    sudo nixos-rebuild switch --flake .#ghastly
