{ pkgs , ...  }:

with pkgs;

[

  # Databases
  postgresql

  # Languages
  go
  python3

  # ** Magic! **
  direnv

]
