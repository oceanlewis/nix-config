{ config
, lib
, pkgs
, theme
, ...
}:

let
  setEncoding = ''
    set encoding=utf-8
  '';

  remapLeader = ''
    " Remap Leader key to Space
    let mapleader = "\<Space>"
  '';

  bufferNavigation = ''
    " Buffer Navigation
    nmap <M-k>  :buffers<CR>
    nmap <M-h>  :bprevious<CR>
    nmap <M-l>  :bnext<CR>
    nmap <M-BS> :bdelete<CR>
  '';

  mouseNavigation = ''
    " Mouse scroll scrolls window, not cursor
    set mouse=a
  '';

  setTabSize = ''
    " Set Tab Size and Indents
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set expandtab
  '';

  fileAndTagNavigation = ''
    " File and Tag Navigation
    nmap <leader>t :Files<CR>
    nmap <leader>r :Tags<CR>
  '';

  reloadConfig = ''
    " Reload Neovim Configuration
    map <leader>s :source ~/.config/nvim/init.vim<cr>
  '';

  toggleVisibleWhitespace = ''
    " Visible Trailing Whitespace and Newlines
    set listchars=eol:¬,tab:>\ ,trail:-,nbsp:+

    function! ToggleVisibleWhitespace()
      if &list
        set list!
      else
        set list
      endif
    endfunc

    map <leader>i :call ToggleVisibleWhitespace()<cr>
  '';

  toggleLineNumbers = ''
    function! ToggleLineNumbering()
      if(&relativenumber == 1)
        set number
        set relativenumber!
      else
        set number
        set relativenumber
      endif
    endfunc

    function! DisableLineNumbering()
      set norelativenumber
      set nonumber
    endfunc

    nnoremap <C-n> :call ToggleLineNumbering()<cr>
    nnoremap <C-A-n> :call DisableLineNumbering()<cr>
  '';

  trimWhitespace = ''
    fun! TrimWhitespace()
        let l:save = winsaveview()
        %s/\s\+$//e
        call winrestview(l:save)
    endfun
    command! TrimWhitespace call TrimWhitespace()
  '';


  languageClientConfig = ''
    let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
    \ }

    " Keybindings for LanguageClient (Language Server Protocol)
    nmap <leader>q :call LanguageClient_textDocument_hover()<CR>
    nmap <leader>w :call LanguageClient_textDocument_definition()<CR>
    nmap <leader>e :call LanguageClient_textDocument_rename()<CR>
  '';

  youCompleteMeConfig = ''
    let g:ycm_language_server =
    \ [
    \   {
    \     'name': 'rust',
    \     'cmdline': ['rust-analyzer'],
    \     'filetypes': ['rust'],
    \     'project_root_files': ['Cargo.toml']
    \   }
    \ ]
  '';

  airlineConfig = ''
    " Airline Configuration
    let g:airline#extensions#tabline#enabled = 1
  '';

  themeConfig = ''
    let g:PaperColor_Theme_Options = {
    \   'theme': {
    \     'default': {
    \       'transparent_background': 1
    \     }
    \   }
    \ }

    let g:gruvbox_contrast_dark  = "hard"
    let g:gruvbox_contrast_light = "medium"

    set termguicolors
    colorscheme ${theme.neovim.colorScheme}

    function! AlignBackground()
      hi Normal guibg=NONE ctermbg=NONE
    endfunc

    nmap <leader>; :call AlignBackground()<cr>
    call AlignBackground()
  '';

in

{
  home.programs.neovim = {
    enable   = true;
    vimAlias = true;
    viAlias  = true;

    withNodeJs  = true;
    withPython  = true;
    withPython3 = true;
    withRuby    = true;

    extraConfig = ''
      ${setEncoding}
      ${remapLeader}
      ${bufferNavigation}
      ${mouseNavigation}
      ${setTabSize}
      ${fileAndTagNavigation}
      ${reloadConfig}
      ${toggleVisibleWhitespace}
      ${trimWhitespace}
      ${toggleLineNumbers}
      ${languageClientConfig}
      ${airlineConfig}
      ${themeConfig}

      " Stop Highlighting on Escape
      nnoremap <esc> :noh<return><esc>

      " Always use the system clipboard for all Copy/Paste operations
      set clipboard+=unnamedplus
    '';

    plugins = with pkgs.vimPlugins; [
      LanguageClient-neovim
      coc-nvim
      coc-solargraph
      vim-nix
      kotlin-vim
      vim-terraform
      dhall-vim

      # UI
      airline
      fzf-vim

      # Themes
      gruvbox-community
      papercolor-theme
    ];
  };

  packages = [];
}
