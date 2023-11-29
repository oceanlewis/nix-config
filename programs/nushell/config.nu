alias e = clear

def r [...paths: string] { e; lsd $paths }
def er [...paths: string] { e; lsd -l $paths }
def err [...paths: string] { e; lsd -lR $paths }
def et [...paths: string] { e; lsd --tree --depth=1 $paths }
def et2 [...paths: string] { e; lsd --tree --depth=2 $paths }
def et3 [...paths: string] { e; lsd --tree --depth=3 $paths }
def et4 [...paths: string] { e; lsd --tree --depth=4 $paths }
def etr [...paths: string] { e; lsd --tree $paths }

def eg  [] { clear; git status }
def egg [] { clear; git status; echo; git diff }
def egc [] { clear; git status; echo; git diff --cached }

# Tmux
def te [] { tmux list-sessions }
def ta [] { tmux attach }

# Zellij
def za [] { zellij attach }
def ze [] { zellij list-sessions }

def tf [] { terraform }

def zvi [] { nvim (fzf --preview 'bat --style=numbers --color=always {}') }
def zhx [] { hx (fzf --preview 'bat --style=numbers --color=always {}') }
def zgc [] { git checkout (git branch | fzf) }

def cdcopy [] { pwd | pbcopy }
def cdpaste [] { cd $"\"(pbpaste)\"" }
