{ pkgs ? import <nixpkgs> {}
, ...
}:

with pkgs;
[

  ## Shells and Unix Environment
  nushell
  elvish
  fish
  starship
  
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
  aws-sam-cli
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
  ruby

  # JVM
  maven

  # Rust
  sccache

]
