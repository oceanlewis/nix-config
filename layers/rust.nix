{ pkgs , ...  }:

{

  packages = with pkgs; [
    rust-analyzer

    rustup
    # cargo-audit
    # cargo-asm
    # cargo-bloat
    # cargo-deps
    cargo-edit
    # cargo-expand
    # cargo-flamegraph
    # cargo-geiger
    # cargo-generate
    # cargo-udeps
    cargo-watch
    # cargo-web
  ];

  vimPlugins = with pkgs.vimPlugins; [
    coc-rust-analyzer
  ];

}
