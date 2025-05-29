{ lib, ... }:
{
  home.activation.makeSymbolicLinks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ln -fsn $VERBOSE_ARG \
      $HOME/.config/nix-config/host/pigeon/scripts ~/.local/scripts
  '';
}
