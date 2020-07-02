{ pkgs , ...  }:

with pkgs;

{

  packages = [
    sccache
    rust-analyzer
  ];

}
