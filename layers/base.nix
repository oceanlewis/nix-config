{ pkgs
, lib
, ...
}:

with pkgs;
let
  platformSpecific =
    lib.optionals pkgs.stdenv.isLinux [
      xsel # rmesg
      xclip
      usbutils # lsusb and others
    ];
in
{

  home.packages = platformSpecific ++ [
    # Files & Text
    file
    exa
    fd
    ripgrep
    sd # grex
    fzf
    zoxide
    bat
    jq
    yq-go
    mdcat
    icdiff
    tokei
    entr
    pv
    wget
    rsync
    unzip

    # Shells and Unix Environment
    elvish
    fish
    (pkgs.callPackage ../packages/dingus.nix {})
    (pkgs.callPackage ../packages/itm.nix {})

    # Chat & Browsing
    irssi
    w3m

    # Identity Management
    gnupg

    ## Writing Tools
    mdbook

    # Process Management
    killall
    htop
    procs
    bandwhich
    bottom

    # Device Management
    smartmontools

    # Networking
    nmap
    httpie
    telnet

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
    gopls

    # Nix
    niv
    nixpkgs-fmt
    rnix-lsp
  ];

}
