{ pkgs, config, lib, ... }:

let

  theme = import ../layers/theme.nix {
    inherit pkgs;
    theme      = "gruvbox";
    variant    = "black";
    fontFamily = "Fira Mono";
    fontSize   = 11.5;
  };

  base = import ../layers/base.nix {
    inherit pkgs;
  };

  devPackages = import ../layers/dev-packages.nix {
    inherit pkgs;
  };

  cloudPlatforms = import ../layers/cloud-platforms.nix {
    inherit pkgs;
  };

  beam = import ../layers/beam.nix {
    inherit pkgs;
  };

  ruby = import ../layers/ruby.nix {
    inherit pkgs;
  };

  rust = import ../layers/rust.nix {
    inherit pkgs;
  };

  jvm = import ../layers/jvm.nix {
    inherit pkgs;
  };

  nodejs = import ../layers/nodejs.nix {
    inherit pkgs;
  };

  dhall = import ../layers/dhall.nix {
    inherit pkgs;
  };

  git = import ../programs/git/git.nix {
    inherit pkgs config lib theme;
    extraGitIgnores = jvm.git.ignores;
  };

  alacritty = import ../programs/alacritty.nix {
    inherit pkgs config lib theme;
  };

  neovim = import ../programs/neovim.nix {
    inherit pkgs config lib theme;
    extraPlugins = (
      dhall.vimPlugins ++
      ruby.vimPlugins ++
      rust.vimPlugins
    );
  };


  shell = import ../layers/posix-shell.nix {
    inherit pkgs;
  };

  zsh = import ../programs/zsh.nix {
    inherit pkgs shell;
  };

  bash = import ../programs/bash.nix {
    inherit pkgs shell;
  };

  tmux = import ../programs/tmux.nix {
    inherit pkgs config lib;
  };

  starship = import ../programs/starship.nix {
    inherit pkgs config lib;
  };

  lorri = import ../services/lorri.nix {
    inherit pkgs config lib;
  };

in

{

  programs = {
    home-manager.enable = true;
    man.enable = false;
  };

  imports = [
    git.home
    bash.home
    alacritty.home
    neovim.home
    zsh.home
    tmux.home
    starship.home
    lorri.home
  ];

  home = {
    username      = "david";
    homeDirectory = "/home/david";

    packages =
      devPackages ++
      base.packages ++
      cloudPlatforms.packages ++
      beam.packages ++
      ruby.packages ++
      rust.packages ++
      jvm.packages ++
      nodejs.packages ++
      git.packages ++
      neovim.packages ++
      dhall.packages ++
      bash.packages ++
      lorri.packages ++ [
        pkgs.ion
        pkgs.neuron-notes
      ];

    extraOutputsToInstall = [ "man" ];
    sessionVariables = {
      PAGER     = "less -R";
      EDITOR    = "nvim";
      VISUAL    = "nvim";
      TERM      = "xterm-256color";
    };

    file.".config/nvim/coc-settings.json".text = ''
      {
      	"languageserver": {
      		"terraform": {
      			"command": "terraform-ls",
      			"args": ["serve"],
      			"filetypes": [
      				"terraform",
      				"tf"
      			],
      			"initializationOptions": {},
      			"settings": {}
      		}
      	}
      }
    '';

    file.".config/nu/config.toml".text = ''
      skip_welcome_message = true
      use_starship = true
      edit_mode = "vi"
      completion_mode = "circular"
      rm_always_trash = true

      table_mode = "light"

      startup = [
        "alias e    [   ] { clear                  }",
        "alias er   [dir] { clear; exa -lg    $dir }",
        "alias r    [dir] { clear; exa        $dir }",
        "alias era  [dir] { clear; exa -la    $dir }",
        "alias err  [dir] { clear; exa -lR    $dir }",
        "alias erra [dir] { clear; exa -lRa   $dir }",
        "alias et   [dir] { clear; exa -TL 1  $dir }",
        "alias eta  [dir] { clear; exa -aTL 1 $dir }",
        "alias et2  [dir] { clear; exa -TL 2  $dir }",
        "alias et3  [dir] { clear; exa -TL 3  $dir }",
        "alias et4  [dir] { clear; exa -TL 4  $dir }",
        "alias etr  [dir] { clear; exa -T     $dir }",
        "alias re   [   ] { clear; exa        *    }",
        "alias rea  [   ] { clear; exa -a     *    }",

        "alias eg  [] { clear; git status }",
        "alias egg [] { clear; git status; echo; git diff }",
        "alias egc  [] { clear; git status; echo; git diff --cached }",

        "alias te [] { tmux list-sessions }",
        "alias ta [] { tmux attach }",

        "alias bat [path] { bat --style=plain $path }",
        "alias dat [path] { ^bat --theme Dracula $path }",
        "alias lat [path] { ^bat --theme GitHub $path }",

        "alias ltop [] { ytop -c default-dark }",
        "alias dtop [] { ytop -c monokai }",

        "alias tf [] { terraform }",

        "alias cdcopy [] { pwd | xsel -ib }",
        "alias cdpaste [] { cd $(xsel -ob) }",
      ]
    '';

    stateVersion = "20.09";
  };

}
