{ pkgs
, config
, lib
, ...
}:

let

  setPrefix = ''
    # Use ` as control character
    unbind C-b
    set -g prefix `
    bind ` send-prefix
  '';

  reloadConfig = ''
    # Reload Tmux configuration
    bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "Tmux configuration reloaded"
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

    # Copy mode is more like Vi
    bind-key -T copy-mode-vi 'v' send -X begin-selection
  '';

  enableMouseIntegration = ''
    # Enable Mouse Integration
    setw -g mouse on
  '';

  enableCopyToSystemClipboard =
    if pkgs.stdenv.isLinux then ''
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
    ''
    else ''
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
    '';

  colors = {
    default = {
      status-fg = "default";
      status-bg = "default";
      pane-active-border-fg = "default";
      mode-style-bg = "#FF9C9C";
      mode-style-fg = "#474646";
    };

    pink = {
      status-fg = "#FF006D";
      status-bg = "default";
      pane-active-border-fg = "#FF006D";
      mode-style-bg = "#87CEFA";
      mode-style-fg = "#FF006D";
    };

    magenta = {
      status-fg = "colour13";
      status-bg = "default";
      pane-active-border-fg = "colour13";
      mode-style-bg = "#947CD3";
      mode-style-fg = "#000000";
    };
  };

  activeColor = colors.default;

  theme = ''
    # Enable TrueColors
    set-option -sa terminal-overrides ',screen-256color:RGB,xterm-256color:RGB'

    # Status Bar and Pane Border
    set -g status-style fg=${activeColor.status-fg},bg=${activeColor.status-bg};
    set-option -g pane-active-border-style fg=${activeColor.pane-active-border-fg}

    # Highlight Color
    set-window-option -g mode-style fg=${activeColor.mode-style-fg},bg=${activeColor.mode-style-bg}
  '';

  style = {
    default = ''
      set -g status-left "" # originally "#S"
      set -g status-right "#{pane_width}x#{pane_height}"
      set -g status-left-length 50
      set -g status-justify left
      set -g status-position bottom
    '';
  };

in

{
  # Program Definition
  # - https://github.com/rycee/home-manager/blob/master/modules/programs/tmux.nix
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "xterm-256color";
    historyLimit = 100000;
    baseIndex = 1;
    escapeTime = 10;
    clock24 = true;

    extraConfig = ''
      ${reloadConfig}
      ${setPrefix}
      ${enableViNavigation}
      ${enableMouseIntegration}
      ${enableCopyToSystemClipboard}
      ${theme}
      ${style.default}
    '';

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
        '';
      }
    ];
  };
}
