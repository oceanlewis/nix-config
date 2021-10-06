{ config, lib, pkgs, modulesPath, ... }:

let
  vscodeExtensions = (with pkgs.vscode-extensions; [
    vscodevim.vim

    bbenoist.nix
    jnoortheen.nix-ide
    arrterian.nix-env-selector

    llvm-org.lldb-vscode
    matklad.rust-analyzer
  ])
  ++
  pkgs.vscode-utils.extensionsFromVscodeMarketplace [ ];

  vscode = pkgs.vscode-with-extensions.override { inherit vscodeExtensions; };

in

{
  environment.systemPackages = [ vscode ];
}
