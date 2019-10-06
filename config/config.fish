# MacOS Fish Config

set -x DEVELOPER "$HOME/Developer"

set --universal --unexport fish_greeting

## Required for GPG Signing of Git Commits
set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

function bold
  tput bold
end

function normal
  tput sgr0
end

# function parse_git_branch_and_add_brackets
#   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\[\1\]/'
# end

function fish_prompt
  # printf "%s => " (bold)(parse_git_branch_and_add_brackets)(normal)
  term_status new || echo '> '
end

function pretty_working_directory
  echo -e (bold)"Current Directory: "(normal)
  pwd
end

function ls
  exa $argv
end

function see
  ls $argv; echo
end

function pop
  clear; see $argv
end

function er
  pop -lg $argv
end

function r
  pop $argv
end

function ra
  pop -a $argv
end

function re
  pop * $argv
end

function rea
  pop * -a $argv
end

function era
  pop -la $argv
end

function err
  pop -lR $argv
end

function erra
  pop -lRa $argv
end

function e
  clear;
  if count $argv > /dev/null
    echo
    ls $argv
  end
end

function ew
  reset;
end

function eg
  e; git status
end

function egg
  e; git status; echo; git diff $argv
end

function cdcopy
  pwd | pbcopy
end

function cdpaste
  cd (pbpaste)
end

function _et
  pop --tree $argv
end

function et
  et1 $argv
end

function etg
  et1 $argv; git status
end

function etr
  _et $argv
end

function et1
  _et -L1 $argv
end

function et2
  _et -L2 $argv
end

function et3
  _et -L3 $argv
end

function et4
  _et -L4 $argv
end

function tmux
  command tmux -2 $argv
end

function te
  e; tmux ls $argv
end

function vi
  command nvim $argv
end

function view
  command nvim -R $argv
end

function more
  less $argv
end

function show_outdated_pip_packages
  pip freeze | cut -d = -f 1 | xargs -n 1 pip search | grep -B2 'LATEST:'
end

function preview
  qlmanage -p $argv > /dev/null ^ /dev/null
end

alias jcat jsonpp



## User Development Environments

set -x HOMEBREW_GITHUB_API_TOKEN '4c3edc6a20c835054c7da0dc7c5419a0f10981ad'

set -x EDITOR   nvim
set -x PAGER    less

# Man Page Path

set -x MANPATH $MANPATH /usr/local/opt/erlang/lib/erlang/man

set -x PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin # /opt/X11/bin

# set -x PATH /usr/local/opt/texinfo/bin    $PATH
set -x PATH $HOME/scripts                 $PATH   # Rust Development
set -x PATH $HOME/.cargo/bin              $PATH   # ...


# Ruby Development
status --is-interactive; and source (rbenv init -|psub)


# Go Development
set -x GOPATH       $DEVELOPER/golang
set -x GOBIN        $GOPATH/bin
set -x PATH         $PATH $GOPATH $GOBIN
set -x GO111MODULE  on


# Python Development
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH # $HOME/.local/bin
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)


# Node Development
status --is-interactive; and . (nodenv init -|psub)


function rust_path
  set -x RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src
end

function pg94
  set -g fish_user_paths "/usr/local/opt/postgresql@9.4/bin"
end

function pg95
  set -g fish_user_paths "/usr/local/opt/postgresql@9.5/bin"
end

function pg96
  set -g fish_user_paths "/usr/local/opt/postgresql@9.6/bin"
end


# Man Pages should be accessible via 'man $PROGRAM'
#set -x MANPATH /usr/local/opt/erlang/lib/erlang/man $MANPATH

function prompt_diff_file
      set_color brgreen; echo $argv[1]; set_color normal
      diff $argv[2] $argv[3]; echo
end

function prompt_icdiff_file
      set_color brgreen; echo $argv[1]; set_color normal
      icdiff $argv[2] $argv[3]; echo
end

function prompt_icdiff_dirs
      set_color brgreen; echo $argv[1]; set_color normal
      icdiff --recursive $argv[2] $argv[3]; echo
end

function prompt_copy_file_to
  set_color brgreen; echo $argv[1]; set_color normal
  if read_confirm
    cp $argv[2] $argv[3]
  end
  echo
end

function prompt_copy_dir_to
  set_color brgreen; echo $argv[1]; set_color normal
  if read_confirm
    cp -r $argv[2] $argv[3]
  end
  echo
end

function diff_config_files
  switch $argv[1]
    case macos
      set -l UNIX_PROFILE_LOCATION $HOME/Developer/Git/UnixEnvironment

      prompt_icdiff_file "Diffing Fish Shell configuration file..." $HOME/.config/fish/config.fish $UNIX_PROFILE_LOCATION/macos/config.fish
      prompt_icdiff_file "Diffing Bash configuration file..." $HOME/.profile $UNIX_PROFILE_LOCATION/macos/macbook_profile
      prompt_icdiff_file "Diffing Vim configuration file..." $HOME/.vimrc $UNIX_PROFILE_LOCATION/vimrc
      prompt_icdiff_file "Diffing NeoVim configuration file..." $HOME/.config/nvim/init.vim $UNIX_PROFILE_LOCATION/macos/init.vim
      prompt_icdiff_file "Diffing Tmux configuration file..." $HOME/.tmux.conf $UNIX_PROFILE_LOCATION/tmux.conf
      prompt_icdiff_dirs "Diffing ~/scripts folder contents..." $HOME/scripts/ $UNIX_PROFILE_LOCATION/macos/scripts/
      #prompt_icdiff_file "Diffing gemrc file..." $HOME/.gemrc $UNIX_PROFILE_LOCATION/macos/gemrc
      prompt_icdiff_file "Diffing ssh config file..." $HOME/.ssh/config $UNIX_PROFILE_LOCATION/macos/ssh_config
      prompt_diff_file "Diffing iTerm2 plist..." $HOME/Library/Preferences/com.googlecode.iterm2.plist $UNIX_PROFILE_LOCATION/macos/com.googlecode.iterm2.plist
      prompt_diff_file "Diffing BetterSnapTool plist..." $HOME/Library/Preferences/com.hegenberg.BetterSnapTool.plist $UNIX_PROFILE_LOCATION/macos/com.hegenberg.BetterSnapTool.plist
  end
end

function read_confirm
  read -l -p 'echo "Are you sure you want to do this? [yes] "' decision

  switch $decision
    case '' Y y yes
      return 0
    case N n no
      return 1
  end
end

function copy_config_files
  switch $argv[1]
    case macos
      set -l UNIX_PROFILE_LOCATION $HOME/Developer/Git/UnixEnvironment/

      prompt_copy_file_to "Copying Fish Shell configuration file..." $HOME/.config/fish/config.fish $UNIX_PROFILE_LOCATION/macos/config.fish
      prompt_copy_file_to "Copying Bash configuration file..." $HOME/.profile $UNIX_PROFILE_LOCATION/macos/macbook_profile
      prompt_copy_file_to "Copying Vim configuration file..." $HOME/.vimrc $UNIX_PROFILE_LOCATION/vimrc
      prompt_copy_file_to "Copying NeoVim configuration file..." $HOME/.config/nvim/init.vim $UNIX_PROFILE_LOCATION/macos/init.vim
      prompt_copy_file_to "Copying Tmux configuration file..." $HOME/.tmux.conf $UNIX_PROFILE_LOCATION/tmux.conf
      prompt_copy_dir_to "Copying ~/scripts folder contents..." $HOME/scripts $UNIX_PROFILE_LOCATION/macos/
      #prompt_copy_file_to "Copying gemrc file..." $HOME/.gemrc $UNIX_PROFILE_LOCATION/macos/gemrc
      prompt_copy_file_to "Copying ssh config file..." $HOME/.ssh/config $UNIX_PROFILE_LOCATION/macos/ssh_config
      prompt_copy_file_to "Copying iTerm2 plist..." $HOME/Library/Preferences/com.googlecode.iterm2.plist $UNIX_PROFILE_LOCATION/macos/com.googlecode.iterm2.plist
      prompt_copy_file_to "Copying BetterSnapTool plist..." $HOME/Library/Preferences/com.hegenberg.BetterSnapTool.plist $UNIX_PROFILE_LOCATION/macos/com.hegenberg.BetterSnapTool.plist

  end
end

function vscode
  open -a 'Visual Studio Code' $argv
end

function firefox
  open -a 'FirefoxDeveloperEdition' $argv
end


test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

function _bat
  command bat -p $argv
end

function bat
  _bat $argv
end

function dat
  bat --theme 1337 $argv
  #bat --theme zenburn $argv
end

function lat
  # command bat --theme 'Monokai Extended Light' $argv
  bat --theme GitHub $argv
end

