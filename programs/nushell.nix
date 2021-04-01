{ pkgs, ...  }:

{
  programs.nushell = {
    enable = true;

    settings = {
      edit_mode            = "vi";
      completion_mode      = "circular";
      rm_always_trash      = true;
      skip_welcome_message = true;
      table_mode           = "light";
      prompt               = "starship prompt";

      env = {
        STARSHIP_SHELL = "nushell";
      };

      startup = [
        "alias e    [   ] { clear                  }"
        "alias er   [dir] { clear; exa -lg    $dir }"
        "alias r    [dir] { clear; exa        $dir }"
        "alias era  [dir] { clear; exa -la    $dir }"
        "alias err  [dir] { clear; exa -lR    $dir }"
        "alias erra [dir] { clear; exa -lRa   $dir }"
        "alias et   [dir] { clear; exa -TL 1  $dir }"
        "alias eta  [dir] { clear; exa -aTL 1 $dir }"
        "alias et2  [dir] { clear; exa -TL 2  $dir }"
        "alias et3  [dir] { clear; exa -TL 3  $dir }"
        "alias et4  [dir] { clear; exa -TL 4  $dir }"
        "alias etr  [dir] { clear; exa -T     $dir }"
        "alias re   [   ] { clear; exa        *    }"
        "alias rea  [   ] { clear; exa -a     *    }"

        "alias eg  [] { clear; git status }"
        "alias egg [] { clear; git status; echo; git diff }"
        "alias egc  [] { clear; git status; echo; git diff --cached }"

        "alias te [] { tmux list-sessions }"
        "alias ta [] { tmux attach }"

        "alias cdcopy [] { pwd | xsel -ib }"
        "alias cdpaste [] { cd $(xsel -ob) }"

        "alias z  [a b c d] { cd $(zoxide query $a $b $c $d | trim) }"
        "alias zi [a b c d] { cd $(zoxide query -i $a $b $c $d | trim) }"
        "alias za [] { zoxide add }"

        ''alias zvi [] { nvim "$(fzf)" }''
      ];
    };
  };

}
