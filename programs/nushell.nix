{ pkgs, ...  }:

{
  home.programs.nushell = {
    enable = true;

    settings = {
      edit_mode            = "vi";
      completion_mode      = "circular";
      rm_always_trash      = true;
      use_starship         = true;
      skip_welcome_message = true;
      table_mode           = "light";

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

        "alias bat [path] { bat --style=plain $path }"
        "alias dat [path] { ^bat --theme Dracula $path }"
        "alias lat [path] { ^bat --theme GitHub $path }"

        "alias ltop [] { ytop -c default-dark }"
        "alias dtop [] { ytop -c monokai }"

        "alias tf [] { terraform }"

        "alias cdcopy [] { pwd | xsel -ib }"
        "alias cdpaste [] { cd $(xsel -ob) }"
      ];
    };
  };
}
