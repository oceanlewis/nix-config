{ config, lib, pkgs, ... }:

let

  theme = import ./colorscheme.nix { inherit pkgs; };

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
    nmap <M-t> :Files<CR>
    nmap <M-f> :Rg<CR>
    nmap <M-r> :Tags<CR>
  '';

  reloadConfig = ''
    " Reload Neovim Configuration
    map <leader>s :source ~/.config/nvim/init.vim<cr>
  '';

  languageClientConfig = ''
    let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
    \ 'nix': ['rnix-lsp'],
    \ 'elixir': ['elixir-ls'],
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
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
    colorscheme ${theme.color_scheme}

    function! AlignBackground()
      hi Normal guibg=NONE ctermbg=NONE
    endfunc
    nmap <leader>; :call AlignBackground()<cr>

    let &background = "${theme.background}"
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
    let g:coc_global_extensions = ['coc-tsserver']

    nmap <leader>c :CocCommand<cr>

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: There's always complete item selected by default, you may want to enable
    " no select by `"suggest.noselect": true` in your configuration file.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ coc#pum#visible() ? coc#pum#next(1) :
          \ CheckBackspace() ? "\<Tab>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
    
    " Make <CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice.
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  '';

  fileContents."coc-settings.json" = ''
    {
      "languageserver": {
        "terraform": {
          "command": "terraform-ls",
          "args": ["serve"],
          "filetypes": ["terraform", "tf"],
          "initializationOptions": {},
          "settings": {}
        },
        "nix": {
          "command": "rnix-lsp",
          "filetypes": ["nix"]
        },
        "elixir": {
          "command": "elixir-ls",
          "filetypes": ["elixir", "eelixir"]
        }
      },
      "coc.preferences.formatOnSaveFiletypes": [
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "graphql",
        "css",
        "markdown",
        "rust"
      ]
    }
  '';

  extraConfig = ''
    ${common}
    ${fzfConfig}
    ${reloadConfig}
    ${airlineConfig}
    ${themeConfig}
    ${cocConfig}

    lua <<EOF
    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
    end

    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local servers = {
      'pyright',
      'rust_analyzer',
      'tsserver',
      'rnix',
    }

    for _, lsp in pairs(servers) do
      require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        flags = {
          -- This will be the default in neovim 0.7+
          debounce_text_changes = 150,
        }
      }
    end

    require'lspconfig'.elixirls.setup{
      cmd = { "${pkgs.elixir_ls}/lib/language_server.sh" };
    }
    EOF
  '';

  plugins = with pkgs.vimPlugins; [
    nvim-tree-lua
    nvim-treesitter
    nvim-lspconfig
    nvim-treesitter

    coc-clangd
    coc-nvim
    coc-pyright
    coc-rust-analyzer
    coc-solargraph
    coc-tsserver
    coc-prettier

    vim-surround

    vim-nix
    vim-terraform
    vim-elixir
    kotlin-vim

    # UI
    airline
    fzf-vim
    nerdtree

    # Themes
    awesome-vim-colorschemes
    vim-gruvbox8

    # Custom (see overlays)
    coc-elixir
    vim-monochrome
    hara
  ];

in
{
  programs.neovim = {
    inherit extraConfig plugins;

    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };

  home = {
    packages = [ pkgs.rust-analyzer ];
    file.".config/nvim/coc-settings.json".text =
      fileContents."coc-settings.json";
  };
}
