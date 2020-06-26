{ config, lib, pkgs, ... }:

let

  setPrefix = ''
    # Use ` as control character
    unbind C-b
    set -g prefix `
  '';

  reloadConfig = ''
    # Reload Tmux configuration
    bind-key r source-file ~/.tmux.conf \; display-message "Tmux configuration reloaded"
  '';

  enableViNavigation = ''
    # Enables navigation between panels
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    bind-key -r -T prefix M-h     resize-pane -L
    bind-key -r -T prefix M-j     resize-pane -D
    bind-key -r -T prefix M-k     resize-pane -U
    bind-key -r -T prefix M-l     resize-pane -R
  '';

  enableMouseIntegration = ''
    # Enable Mouse Integration
    setw -g mouse on
  '';

  colors = {

    default = {
      status-fg             = "default";
      status-bg             = "default";
      pane-active-border-fg = "default";
      mode-style-bg         = "default";
      mode-style-fg         = "default";
    };

    pink = {
      status-fg             = "#FF006D";
      status-bg             = "default";
      pane-active-border-fg = "#FF006D";
      mode-style-bg         = "#87CEFA";
      mode-style-fg         = "#FF006D";
    };

    magenta = {
      status-fg             = "colour13";
      status-bg             = "default";
      pane-active-border-fg = "colour13";
      mode-style-bg         = "#947CD3";
      mode-style-fg         = "#000000";
    };

  };

  activeColor = colors.magenta;

  theme = ''
    # Status Bar and Pane Border
    set -g status-style fg=${activeColor.status-fg},bg=${activeColor.status-bg};
    set-option -g pane-active-border-style fg=${activeColor.pane-active-border-fg}

    # Highlight Color
    set-window-option -g mode-style fg=${activeColor.mode-style-fg},bg=${activeColor.mode-style-bg}
  '';

  style = {
    default = ''
      set -g status-left "#S"
      set -g status-right ""
      set -g status-left-length 50
      set -g status-justify right
      set -g status-position bottom
    '';
  };

  aesthetics = ''
    ${theme}
    ${style.default}
  '';

in

{

  # Program Definition
  # - https://github.com/rycee/home-manager/blob/master/modules/programs/tmux.nix
   programs.tmux = {
    enable = true;
    keyMode       = "vi";
    terminal      = "screen-256color";
    historyLimit  = 100000;
    baseIndex     = 1;
    escapeTime    = 10;
    clock24       = true;

    extraConfig = ''
      ${setPrefix}
      ${reloadConfig}
      ${enableViNavigation}
      ${enableMouseIntegration}
      ${aesthetics}
    '';
  };

}
