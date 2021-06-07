{ pkgs, ...  }:

{
  programs.nushell = {
    enable  = true;
    package = pkgs.nushell;

    settings = {
      line_editor = {
        edit_mode = "vi";
        completion_mode = "circular";
      };

      skip_welcome_message = true;
      table_mode           = "light";
      prompt               = "starship prompt";

      env = {
        STARSHIP_SHELL = "nushell";
      };

      startup = [
        "alias e    = clear"
        "alias er   = exa -lg"
        "alias r    = exa"
        "alias era  = exa -la"
        "alias err  = exa -lR"
        "alias erra = exa -lRa"
        "alias et   = exa -TL 1"
        "alias eta  = exa -aTL 1"
        "alias et2  = exa -TL 2"
        "alias et3  = exa -TL 3"
        "alias et4  = exa -TL 4"
        "alias etr  = exa -T"
        "alias re   = exa *"
        "alias rea  = exa -a *"

        "alias eg  = { clear; git status }"
        "alias egg = { clear; git status; echo; git diff }"
        "alias egc = { clear; git status; echo; git diff --cached }"

        "alias te = tmux list-sessions"
        "alias ta = tmux attach"

        "alias cdcopy  = { pwd | xsel -ib }"
        "alias cdpaste = { cd $(xsel -ob) }"

        # "alias z  [a b c d] { cd $(zoxide query $a $b $c $d | trim) }"
        # "alias zi [a b c d] { cd $(zoxide query -i $a $b $c $d | trim) }"
        # "alias za [] { zoxide add }"

        ''alias zvi = { nvim "$(fzf)" }''
      ];
    };
  };

}
