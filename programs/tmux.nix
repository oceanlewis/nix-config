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

  themes = {
    brightPink = ''
      # Bright Pink and Default Background
      set -g status-style fg="#FF006D",bg=default;
      set-option -g pane-active-border-style fg="#FF006D"

      # Highlight Color
      set-window-option -g mode-style bg="#87CEFA",fg="#FF006D"
    '';
  };

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
    ${themes.brightPink}
    ${style.default}
  '';

in

{
   programs.tmux = {
    enable = true;
    keyMode = "vi";
    historyLimit = 100000;
    baseIndex = 1;
    escapeTime = 10;

    extraConfig = ''
      ${setPrefix}
      ${reloadConfig}
      ${enableViNavigation}
      ${enableMouseIntegration}
      ${aesthetics}
    '';
  };
}
