{ pkgs , ...  }:

with pkgs;

{

  packages = [

    ## Shells and Unix Environment
    elvish
    fish

    # Chat & Browsing
    irssi
    w3m
    
    # Identity Management
    gnupg
    
    ## Writing Tools
    mdbook
    neuron-notes

    # Build Tools
    autoconf
    pkg-config

    # Files & Text
    exa
    fzf
    zoxide
    bat
    mdcat
    jq
    diffr
    icdiff
    tokei
    entr
    pv
    dua
    du-dust
    fd
    ripgrep
    wget
    rsync

    # Process Management
    htop
    ytop
  
    # Networking
    nmap
 
    # Content
    youtube-dl

  ];

}
