{ pkgs, shell, ...  }:

{
  # Program Definition
  # - https://github.com/rycee/home-manager/blob/master/modules/programs/zsh.nix
  programs.zsh = {
    enable        = true;
    dotDir        = ".config/zsh";
    shellAliases  = shell.aliases;
    initExtra     = ''
      set -o vi

      ${shell.initExtra}
      unset RPS1

      if test -x "$(which zoxide)"; then
        eval "$(zoxide init zsh)"
      fi
    '';

    defaultKeymap = "viins";

    oh-my-zsh = {
      enable = true;
      plugins = [
        "vi-mode"
        "history-substring-search"
      ];
    };
  };
}
