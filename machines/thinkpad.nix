let

  programs = {
    home-manager.enable = true;
  
    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
  
      # plugins = with pkgs.vimPlugins; [];
    };
  };
  #packages = import ./overlays/development-pkgs.nix { pkgs = pkgs; };

in

{ config, pkgs, ... }:
{
  home.stateVersion = "20.09";
  home.username = "david";
  home.homeDirectory = "/home/david";
  home.packages = with pkgs; [

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

  ];
  #programs.home-manager.enable = true;
  programs = programs;

  ## macbook = { pkgs, ... }: {
  ##   home.stateVersion = "20.09";
  ##   home.packages = packages;
  ##   programs = programs;
  ## };

  ## thinkpad = { config, pkgs, ... }: {
  ##   home.stateVersion = "20.09";
  ##   home.username = "david";
  ##   home.homeDirectory = "/home/david";
  ##   home.packages = (packages ++ [ pkgs.ion ]);
  ## };

}
