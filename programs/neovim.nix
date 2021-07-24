{ config
, lib
, pkgs
, theme
, extraPlugins
, ...
}:

let

  vim-colors-xcode = pkgs.vimUtils.buildVimPlugin {
    name = "vim-colors-xcode";
    src = pkgs.fetchFromGitHub {
      owner = "arzg";
      repo = "vim-colors-xcode";
      rev = "26707a8d9d17d5e4fcd3835cd6b5086c680c6fc6";
      sha256 = "sha256:0ij5597a2i9grxm7xahh9niywkz8ljafpg82f6m8g0syq9b47lzq";
    };
  };

  common = ''
    " Use UTF-8 encoding
    set encoding=utf-8


    " Remap Leader key to Space
    let mapleader = "\<Space>"


    " Mouse scroll scrolls window, not cursor
    set mouse=a


    " Buffer Navigation
    nmap <M-k>  :buffers<CR>
    nmap <M-h>  :bprevious<CR>
    nmap <M-l>  :bnext<CR>
    nmap <M-BS> :bdelete<CR>


    " Set Tab Size and Indents
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set expandtab


    " Wrap on words
    set linebreak


    " Stop Highlighting on Escape
    nnoremap <esc> :noh<return><esc>


    " Always use the system clipboard for all Copy/Paste operations
    set clipboard+=unnamedplus


    " Toggling visibility of trailing whitespace and newlines
    set listchars=eol:¬,tab:>\ ,trail:-,nbsp:+

    function! ToggleVisibleWhitespace()
      if &list
        set list!
      else
        set list
      endif
    endfunc
    map <leader>i :call ToggleVisibleWhitespace()<cr>


    " Toggling visibility of line numbers using Control-N and Control-Alt-N
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


    " Trim trailing whitespace on all lines
    fun! TrimWhitespace()
        let l:save = winsaveview()
        %s/\s\+$//e
        call winrestview(l:save)
    endfun
    command! TrimWhitespace call TrimWhitespace()
  '';

  fzfConfig = ''
    " FZF Configuration
    nmap <leader>t :Files<CR>
    nmap <leader>f :Rg<CR>
    nmap <leader>r :Tags<CR>
  '';

  reloadConfig = ''
    " Reload Neovim Configuration
    map <leader>s :source ~/.config/nvim/init.vim<cr>
  '';

  languageClientConfig = ''
    let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
    \ 'nix': ['rnix-lsp'],
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

    " Tab and Shift-Tab navigate completion list
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    " Enter confirms completion selection
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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

    function! ToggleBackground()
      if &background == "light"
        let &background = "dark"
      else
        let &background = "light"
      endif
      call AlignBackground()
    endfunc
    nmap <leader>l :call ToggleBackground()<cr>

    " Automatically call AlignBackground when opening vim
    autocmd VimEnter * :call AlignBackground()
  '';

  cocConfig = ''
    nmap <leader>c :CocCommand<cr>
  '';

  fileContents."coc-settings.json" = ''
    {
      "languageserver": {
        "terraform": {
          "command": "terraform-ls",
          "args": ["serve"],
          "filetypes": [
            "terraform",
            "tf"
          ],
          "initializationOptions": {},
          "settings": {}
        },
        "nix": {
          "command": "rnix-lsp",
          "filetypes": [
            "nix"
          ]
        }
      }
    }
  '';

in {

  programs.neovim = {
    enable       = true;
    vimAlias     = true;
    viAlias      = true;
    vimdiffAlias = true;
    withNodeJs   = true;
    withPython3  = true;
    withRuby     = true;

    extraConfig = ''
      ${common}

      ${fzfConfig}
      ${reloadConfig}
      ${languageClientConfig}
      ${cocConfig}
      ${youCompleteMeConfig}
      ${airlineConfig}
      ${themeConfig}
    '';

    plugins = with pkgs.vimPlugins; [
      LanguageClient-neovim
      coc-nvim
      coc-tsserver
      coc-pyright
      vim-nix
      kotlin-vim
      vim-terraform
      #neuron-vim

      # UI
      airline
      fzf-vim
      nerdtree

      # Themes
      gruvbox-community
      papercolor-theme
      oceanic-next
      onehalf
      vim-colors-xcode
    ] ++ extraPlugins;
  };

  home.packages = [];
  home.file.".config/nvim/coc-settings.json".text = fileContents."coc-settings.json";

}
