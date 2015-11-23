" Installation instructions for Arch Linux:
"
"    1. Download this file and save it to `~/.vimrc`
"
"    2. Install Vim
"        $ pacman -S gvim-python3
"
"    3. Install `python-powerline-git` from the AUR
"
"    4. Install Vundle
"        $ git clone http://git.io/b51VEw ~/.vim/bundle/Vundle.vim
"
"    5. Install Vundle plugins
"        $ vim +PluginInstall +qall
"

" Essential {{{
    set nocompatible            " Modernise
    filetype off                " Required by Vundle
    let mapleader = "\<Space>"  " Override mapleader
" }}}

" Runtime Paths {{{
    set runtimepath+=~/.vim/bundle/Vundle.vim
" }}}

" Plugins {{{
    call vundle#begin()
    Plugin 'bps/vim-textobj-python'
    Plugin 'davidhalter/jedi-vim'
    Plugin 'fisadev/vim-isort'
    Plugin 'flazz/vim-colorschemes'
    Plugin 'hail2u/vim-css3-syntax'
    Plugin 'jamessan/vim-gnupg'
    Plugin 'kana/vim-textobj-user'
    Plugin 'kien/ctrlp.vim'
    Plugin 'Matt-Deacalion/vim-systemd-syntax'
    Plugin 'mileszs/ack.vim'
    Plugin 'ntpeters/vim-better-whitespace'
    Plugin 'scrooloose/syntastic'
    Plugin 'terryma/vim-expand-region'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-speeddating'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'vim-scripts/restore_view.vim'
    call vundle#end()
" }}}

" General {{{
    syntax on                   " Syntax highlighting
    filetype plugin indent on   " Enable detection of filetype
    set wildmenu                " Menu completion in command mode on <Tab>
    set noswapfile              " No messy swap files (this is also more secure)
    set history=2000            " Remember more Ex-Commands

    " ignore
    set wildignore+=*.swp,*.bak,.git,*.jpg,*.gif,*.png,*.pyc,*.pdf,*.zip,*.gz
" }}}

" Appearance {{{
    colorscheme Tomorrow-Night  " Other options: Monokai, Gotham, Chasing-Logic
    set t_Co=256                " Enable full colour within the terminal
    set colorcolumn=100         " Add a red line at 100 chars (not quite PEP 8, but it's 2014)
    set cursorline              " Display a horizontal line at the cursor position
    set laststatus=2            " Always show statusline, even if only a single window
    set guioptions-=L           " Remove left scrollbar
    set guioptions-=m           " Remove top menu
    set guioptions-=r           " Remove scrollbar
    set guioptions-=T           " Remove shortcut icons
    set guifont=Inconsolata\ For\ Powerline\ Medium\ 14
" }}}

" Searching {{{
    set gdefault                " Assume the /g flag on :s substitutions
    set hlsearch                " Highlight search matches
    set ignorecase              " Default to using case insensitive searches,
    set incsearch               " Incrementally search while typing a /regex
    set smartcase               " Unless uppercase letters are used in the regex
    set smarttab                " Handle tabs more intelligently
" }}}

" Movement {{{
    set relativenumber          " Relative line numbers
    set number                  " Enable 'hybrid' line number mode
    set scrolloff=5             " Begin scrolling before cursor hits the top/bottom
    set sidescrolloff=20        " Begin scrolling before cursor hits the right hand side
" }}}

" Git Commit Editing {{{
    " Add a red line at 72 chars, keeping commit messages short n' sweet and turn on spellcheck.
    autocmd FileType gitcommit setlocal textwidth=72 colorcolumn=72 spell
" }}}

" Editing {{{
    set confirm                 " Y-N-C prompt if closing with unsaved changes
    set expandtab               " Convert tabs to tabstop * spaces
    set nowrap                  " Disable text wrapping
    set shiftwidth=4            " How much to indent with '>>'
    set softtabstop=4           " Should be the same as 'tabstop'
    set spelllang=en_gb         " Set region to British English
    set tabstop=4               " A tab is four spaces, not eight (the default)
" }}}

" Folding {{{
    set foldmethod=indent       " Allow us to fold on indents
    set foldlevelstart=20       " Don't fold by default

    " Fold Vim configuration files
    autocmd FileType vim setlocal foldmethod=marker
" }}}

" Disable {{{
    " Only use the hjkl keys for movement
    map <Up>    <Nop>
    map <Down>  <Nop>
    map <Left>  <Nop>
    map <Right> <Nop>

    " The same applies to insert mode
    imap <Up>    <Nop>
    imap <Down>  <Nop>
    imap <Left>  <Nop>
    imap <Right> <Nop>

    " Disable the backspace bar (use '^w')
    inoremap <BS> <Nop>

    " Use 'jj' instead of Escape
    inoremap <Esc> <Nop>

    " Never needed undo in visual mode, always accidentally hitting it
    vnoremap u <Nop>
" }}}

" Remappings and Shortcuts {{{
    " Open a new file
    nnoremap <Leader>o :CtrlP<CR>

    " Save file
    nnoremap <Leader>w :w<CR>

    " Search buffers
    nnoremap <Leader>b :CtrlPBuffer<CR>

    " System clipboard access
    vmap <Leader>y "+y
    vmap <Leader>d "+d
    nmap <Leader>p "+p
    nmap <Leader>P "+P
    vmap <Leader>p "+p
    vmap <Leader>P "+P

    " Jump to the end of pasted lines
    vnoremap <silent> y y`]
    vnoremap <silent> p p`]
    nnoremap <silent> p p`]

    " Quickly get out of insert mode
    inoremap jj <Esc>

    " Expand region
"    vmap v <Plug>(expand_region_expand)
"    vmap <C-v> <Plug>(expand_region_shrink)

    " Improve movement on wrapped lines (when wrapping is enabled)
    nnoremap j gj
    nnoremap k gk

    " Quick yanking to the end of the line
    nnoremap Y y$

    " Ctrl+[jklm] to navigate splits
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
    map <C-h> <C-w>h

    " Jump to the beginning and end of the file
    nnoremap <CR> G
    nnoremap <BS> gg

    " Clear the search buffer
    nmap <silent> ,/ :nohlsearch<CR>

    " Cycle through buffers
    nnoremap <Tab> :bnext<CR>
    nnoremap <S-Tab> :bprevious<CR>

    " F1 toggles folds
    nnoremap <F1> za
    vnoremap <F1> za

    " F2 toggles paste mode
    nnoremap <silent> <F2> :set paste!<CR>

    " F4 toggles spell checking
    nnoremap <silent> <F4> :set spell!<CR>

    " F5 strips trailing white space
    nnoremap <silent> <F5> :StripWhitespace<CR>

    " Reselect visual block after indent/outdent
    vnoremap < <gv
    vnoremap > >gv

    " Sort (alphabetical, not numerical)
    vnoremap <Leader>s :!sort<CR>

    " Turn off Vim's default regular expression handling and use Perl's
    nnoremap / /\v
    vnoremap / /\v

    " Keep search matches in the middle of the window
    nnoremap n nzzzv
    nnoremap N Nzzzv

    " Select current line excluding indentation
    nnoremap <Leader>v ^vg_

    " Allow saving of files as root
    cmap w!! w !sudo tee > /dev/null %
" }}}

" Auto commands {{{
    " Remove trailing white space just before saving
    autocmd BufWritePre * :StripWhitespace
" }}}

" Python {{{
    " Ignore line length
    let g:syntastic_python_flake8_args='--ignore=E501'

    " Disable the isort key combination, use the explicity ':Isort' instead
"    let g:vim_isort_map = ''
" }}}
"
" Behaviour {{{
    set noerrorbells            " Shut those bells up
    set novisualbell            " The same goes for visual bells
" }}}

" Cursorline {{{
    " Only show the cursor line within the active window
    augroup CursorLine
        autocmd!
        autocmd WinLeave * set nocursorline
        autocmd VimEnter,WinEnter * set cursorline
    augroup END
" }}}

" vim:ft=vim
