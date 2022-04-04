{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;

    settings = {
      line_editor = {
        edit_mode = "vi";
        completion_mode = "circular";
      };

      skip_welcome_message = true;
      table_mode = "light";
      prompt = "starship prompt";

      env = {
        STARSHIP_SHELL = "nushell";
      };

      startup = [
        "alias e = { clear }"
        "alias er = { clear; lsd -l }"
        "alias era = { clear; lsd -la }"
        "alias err = { clear; lsd -lR }"
        "alias erra = { clear; lsd -lRa }"
        "alias et = { clear; lsd --tree --depth 1 }"
        "alias et2 = { clear; lsd --tree --depth 2 }"
        "alias et3 = { clear; lsd --tree --depth 3 }"
        "alias et4 = { clear; lsd --tree --depth 4 }"
        "alias eta = { clear; lsd -a --tree --depth 1 }"
        "alias etr = { clear; lsd --tree }"
        "alias r = { clear; lsd }"
        "alias re = { clear; lsd * }"
        "alias rea = { clear; lsd -a * }"

        "alias eg  = { clear; git status }"
        "alias egg = { clear; git status; echo; git diff }"
        "alias egc = { clear; git status; echo; git diff --cached }"

        "alias te = { tmux list-sessions }"
        "alias ta = { tmux attach }"

        "alias zvi = { nvim (fzf) }"
      ];
    };
  };
}
