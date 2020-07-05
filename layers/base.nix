{ pkgs , ...  }:

with pkgs;

{

  packages = [

    ## Shells and Unix Environment
    nushell
    elvish
    fish
    
    # Chat & Browsing
    irssi
    w3m
    
    # Identity Management
    gnupg
    
    ## Developer Tools
    mdbook

    # Build Tools
    autoconf
    pkg-config

    # Files & Text
    exa
    fzf
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
