{ pkgs, ... }: {

  packages = with pkgs; [
    rustup
    rust-analyzer
    cargo-edit
    cargo-watch
    cargo-udeps
  ];

  vimPlugins = with pkgs.vimPlugins; [
    coc-rust-analyzer
  ];
}
