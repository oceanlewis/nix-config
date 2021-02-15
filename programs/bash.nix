{ pkgs, shell, ...  }:

{
  programs.bash = {
    enable         = true;
    shellAliases   = shell.aliases;
    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
    historyIgnore  = [ "ls" "cd" "exit" ];

    initExtra    = ''
      set -o vi

      if test -x "$(which zoxide)"; then
        eval "$(zoxide init bash)"
      fi

      ${shell.initExtra}
    '';
  };

  home.packages = with pkgs; [ bashInteractive_5 ];
}
