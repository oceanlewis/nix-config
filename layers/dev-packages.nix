{ pkgs , ...  }:

with pkgs; [

  # Databases
  postgresql

  # Languages
  go

  # Nix
  niv
  nixpkgs-fmt
  manix

]
