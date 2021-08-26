{ pkgs
, lib
, ...
}:

with pkgs; 
let
  platformSpecific =
    lib.optionals pkgs.stdenv.isLinux [
      xsel # rmesg
    ];
in {

  home.packages = platformSpecific ++ [
    # Files & Text
    exa fd ripgrep sd # grex
    fzf zoxide
    bat jq yq-go mdcat
    icdiff
    tokei
    entr
    pv
    wget rsync
    unzip

    # Shells and Unix Environment
    elvish fish
    (pkgs.callPackage ../packages/dingus.nix {})

    # Chat & Browsing
    irssi w3m
    
    # Identity Management
    gnupg
    
    ## Writing Tools
    mdbook

    # Process Management
    htop procs bandwhich
    bottom
    
    # Networking
    nmap httpie
 
    # Content
    youtube-dl

    # Build Tools
    # autoconf pkg-config gnumake

    # Databases
    postgresql

    # Languages
    go gopls

    # Nix
    niv nixpkgs-fmt rnix-lsp
  ];

}
