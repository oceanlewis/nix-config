{ pkgs , ...  }:

with pkgs; [

  gnumake

  # Databases
  postgresql

  # Languages
  go

  # Nix
  niv
  nixpkgs-fmt
  rnix-lsp

]
