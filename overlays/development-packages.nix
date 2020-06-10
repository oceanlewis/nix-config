{ pkgs, ... }:

with pkgs; [

  ## Shells and Unix Environment
  nushell elvish fish
  tmux starship
  
  # Chat & Browsing
  irssi w3m
  
  ## Files & Text
  # List
  exa
  # Search
  fd ripgrep
  # Read
  bat mdcat diffr tokei
  # Manage
  entr pv trash-cli
  # Usage
  dua du-dust
  # Fetch
  wget rsync youtube-dl
  
  # Identity Management
  gnupg
  
  # Process Management
  htop ytop
  
  # Networking
  nmap
  
  ## Developer Tools
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
  terraform terraform-lsp
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

]
