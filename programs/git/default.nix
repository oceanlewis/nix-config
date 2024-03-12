{ pkgs
, config
, lib
, ...
}:

with pkgs;
{
  home.packages = [
    gitAndTools.delta
    gitAndTools.git-crypt
    gitAndTools.lfs
    github-cli
    gitu
    act
    difftastic
  ];

  # Program Definition
  # - https://github.com/rycee/home-manager/blob/master/modules/programs/git.nix
  programs.git = {
    enable = true;

    delta = {
      enable = true;
      options = {
        syntax-theme = lib.optionalString (theme.delta != null) theme.delta;
      };
    };

    userName = "Ocean Armstrong Lewis";
    userEmail = "6754950+oceanlewis@users.noreply.github.com";

    extraConfig = {
      core.editor = "hx";
      init.defaultBranch = "main";
      pull.ff = "only";

      diff.tool = "difftastic";
      difftool.prompt = false;
      "difftool \"difftastic\"".cmd = ''difft "$LOCAL" "$REMOTE"'';
      pager.difftool = true;
      alias.difft = "difftool";
    };

    ignores = [
      ## from programs.git.ignores in ../default.nix
      # Elixir
      ".env.local"

      # JVM
      "**/.idea"
      "/.classpath"
      "/.project"
      "/.settings"

      # VSCode
      ".vscode"

      # macOS
      ".DS_Store"

      # clangd
      ".cache"

      # Nix
      ".direnv"
      ".envrc"
      ".nix-mix"
      ".nix-hex"
    ];

    includes = [
      {
        path = ./hg/config;
        condition = "gitdir:~/Developer/hg/";
      }
    ];

    aliases = {
      lg1-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";

      lg2-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";

      lg3-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'";

      lg1 = "lg1-specific --all";
      lg2 = "lg2-specific --all";
      lg3 = "lg3-specific --all";
      lg = "lg1";
    };
  };
}

