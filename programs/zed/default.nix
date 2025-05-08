{ lib, ... }:
let
  source = "$HOME/.config/nix-config/programs/zed/config";
  target = "$HOME/.config/zed";
in
{
  home.activation.linkZedConfiguration = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p ${source}

    run ln -sf $VERBOSE_ARG \
        ${source}/* ${target}/
  '';
}
