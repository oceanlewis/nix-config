#!/usr/bin/env nu

def main [] {
  nu -c $"($env.PROCESS_PATH) --help"
}

def "main jellyfin" [] {
    cd ~/Server/jellyfin
    ls
}
