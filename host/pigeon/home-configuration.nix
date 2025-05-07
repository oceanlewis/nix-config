{ lib, ... }:
{
  home.activation = {
    makeSymbolicLinks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run ln -sf $VERBOSE_ARG \
        $HOME/.config/nix-config/host/pigeon/scripts ~/.local/scripts
    '';
  };
}
