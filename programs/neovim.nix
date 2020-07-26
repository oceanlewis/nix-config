{ config
, lib
, pkgs
, theme
, extraPlugins
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
    nmap <leader>h :call LanguageClient_textDocument_hover()<CR>
    nmap <leader>d :call LanguageClient_textDocument_definition()<CR>

    " Language Client - Open Context Menu
    nnoremap <leader><leader> :call LanguageClient_contextMenu()<CR>

    " Rename - rn => rename
    noremap <leader>rn :call LanguageClient#textDocument_rename()<CR>

    " Rename - rc => rename camelCase
    noremap <leader>rc :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.camelcase(expand('<cword>'))})<CR>

    " Rename - rs => rename snake_case
    noremap <leader>rs :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>

    " Rename - ru => rename UPPERCASE
    noremap <leader>ru :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>
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
    let g:gruvbox_contrast_light = "hard"

    set termguicolors
    colorscheme ${theme.neovim.colorScheme}

    function! AlignBackground()
      hi Normal guibg=NONE ctermbg=NONE
    endfunc
    nmap <leader>; :call AlignBackground()<cr>

    let &background = "${theme.neovim.background}"
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
      vim-nix
      kotlin-vim
      vim-terraform

      # UI
      airline
      fzf-vim

      # Themes
      gruvbox-community
      papercolor-theme
    ] ++ extraPlugins;
  };

  packages = [];
}
