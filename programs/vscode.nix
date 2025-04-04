{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
let
  extensions =
    (with pkgs.vscode-extensions; [
      vscodevim.vim

      bbenoist.nix
      jnoortheen.nix-ide
      arrterian.nix-env-selector

      llvm-org.lldb-vscode
      matklad.rust-analyzer
      usernamehw.errorlens

      github.github-vscode-theme
    ])
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "nebula-theme";
        publisher = "ChirtleLovesDolls";
        version = "1.3.3";
        sha256 = "1znb2df6nw0iryk1952p1yrbyi3shyv8k8q54nrc5x9p7pzk52f3";
      }
      {
        name = "gruvbox-material";
        publisher = "sainnhe";
        version = "6.5.0";
        sha256 = "17xddfkxfgj9qls1364c8iqk359rk0k6fc6xpl93zzqr43hx4vxf";
      }
      {
        name = "gruvbox-concoctis";
        publisher = "wheredoesyourmindgo";
        version = "6.5.0";
        sha256 = "17xddfkxfgj9qls1364c8iqk359rk0k6fc6xpl93zzqr43hx4vxf";
      }
      {
        name = "gruvbox";
        publisher = "jdinhlife";
        version = "1.7.0";
        sha256 = "0bxwkqf73y0mlb59gy3rfps0k5fyj1yqhifidjvdaswn9z84226j";
      }
    ];
in
{
  programs.vscode = {
    inherit extensions;
    enable = true;
  };
}
