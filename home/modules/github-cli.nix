{ pkgs, ...  }:

with pkgs; {

  home.packages = [ github-cli ];

  home.file.".config/gh/config.yml" = {
    text = ''
      git_protocol:
        ssh
      pager:
        mdcat
    '';
  };

}
