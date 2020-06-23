{ pkgs ? import <nixpkgs> {}
, ...
}:

with pkgs;
[

  ## Shells and Unix Environment
  #nushell # Broken
  elvish
  fish
  
  # Chat & Browsing
  irssi
  w3m
  
  # Files & Text
  exa
  fd
  ripgrep
  fzf
  bat
  mdcat
  diffr
  icdiff
  tokei
  entr
  pv
  dua
  du-dust
  wget
  rsync
  youtube-dl
  
  # Identity Management
  gnupg
  
  # Process Management
  htop
  ytop
  
  # Networking
  nmap
  
  ## Developer Tools
  mdbook

  # Git
  gitAndTools.git
  gitAndTools.gh
  gitAndTools.delta

  # Build Tools
  autoconf
  pkg-config

  # Cloud Tooling
  #aws-sam-cli # Broken
  awscli
  terraform
  terraform-lsp # TODO: Replace with terraform-ls when it's ready

  # Databases
  postgresql

  # Languages
  elixir
  erlang
  go
  nodejs
  python3

  /*
   * Ruby
   *
   * See the docs on Ruby in NixPkgs
   * - https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/ruby.section.md
   * - https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/ruby-modules/with-packages/default.nix
   */
  (ruby.withPackages (selector:
    with selector; [
      nokogiri
      pry
    ]
  ))
  solargraph

  ## JVM
  #maven
  #openjdk8
  #kotlin

  # Rust
  sccache

]
