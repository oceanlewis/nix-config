{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;

    configFile.text = ''
      let-env config = {
        show_banner: false
        filesize_metric: false
        table_mode: rounded
        use_ls_colors: true
      }
    '';

    envFile.text = ''
      let-env FOO = 'BAR'
    '';
  };
}
