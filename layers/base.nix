{ pkgs
, lib
, ...
}:

with pkgs; 
let
  platformSpecific =
    lib.optionals pkgs.stdenv.isLinux [
      xsel
    ];
in {
  home.packages = platformSpecific ++ [
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
    unzip

    # Shells and Unix Environment
    elvish
    fish

    # Chat & Browsing
    irssi
    w3m
    
    # Identity Management
    gnupg
    
    ## Writing Tools
    mdbook

    # Process Management
    htop
    # bottom
    
    # Networking
    nmap
 
    # Content
    youtube-dl

    # Build Tools
    autoconf
    pkg-config
    gnumake

    # Databases
    postgresql

    # Languages
    go

    # Nix
    niv
    nixpkgs-fmt
    rnix-lsp
  ];
}
