" Credit to tecywiz121 for stolen configurations.
" https://github.com/tecywiz121/neovim/blob/master/config/init.vim

" Detects the type of the current file based of the extension and contents,
" and perform actions.
filetype on                                       " Enable the plugin.
filetype indent on                                " Better indentation.
filetype plugin on                                " Load filetype specific
                                                  " plugins.

" Load plugins {{
    call plug#begin('~/.vim/plugged')
    " Colors and UI
        Plug 'morhetz/gruvbox'
	Plug 'freeo/vim-kalisi'
	Plug 'joshdick/onedark.vim'
        Plug 'bling/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
    " Utility Plugins
        Plug 'scrooloose/nerdcommenter'
        Plug 'scrooloose/nerdtree'
        Plug 'ambv/black'
        " Github added/deleted lines
        Plug 'mhinz/vim-signify'
        " Syntax highlighting
        Plug 'digitaltoad/vim-pug'
        " Autocompletion
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        " FuzzySearch
        Plug 'junegunn/fzf'
        " Detect code indents
        Plug 'roryokane/detectindent'
    " Language Specific
        "A collection of language packs for Vim.
        Plug 'sheerun/vim-polyglot'
        " SaltStack
        Plug 'saltstack/salt-vim'
        " Rust
        Plug 'rust-lang/rust.vim'
        " Golang
        Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
        " Jenkinsfile
        Plug 'martinda/Jenkinsfile-vim-syntax'
        " Dockerfile
        Plug 'ekalinin/dockerfile.vim'
        " Useful tools
        Plug 'w0rp/ale'
        "
    call plug#end()
"}

" Nvim specific {
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" }

" Look and feel {
    set termguicolors
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

	syntax enable
	colorscheme onedark
	set background=dark

	" Enable mouse support
	set mouse=a
"}

" General {
    scriptencoding utf-8

    " Show line numbers
    set number

    " Highlight current line and set ruler at col 100
    set cursorline
    set colorcolumn=100
    " Or if you only want to highlight where you exceed 100:
    match ColorColumn "\%>99v."

    " Small changes that make vim a little easier to use.
    set wildchar=<Tab> wildmenu wildmode=longest,list " Bash-like completion.
    set backspace=indent,eol,start                    " Backspace anything!
    set expandtab                                     " Use spaces by default.
    set hidden                                        " Switch buffers w/o saving.
    set completeopt-=preview                          " Disable completion preview.
    set splitright                                    " Open new split to the right.
    "set nohlsearch                                    " Disable highlight search.
    set relativenumber                                " Show relative line numbers.
    set inccommand=nosplit                            " Preview substitutions.
    set copyindent                                    " Copy previous indent on <CR>.
    set fillchars+=vert:│                             " Nicer vsplit separator.
    set number                                        " On current line, show
                                                      " absolute line number.
"}

" Edit {
    " Allow cursor after last line character
    set virtualedit=onemore

    " Automatically reload modified files
    set autoread

    " Undo
    set undolevels=1000 " Lots of undo, I screw up a lot

    " Prevent cursor from moving one position to the left when exiting insert mode
    au InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])

    " Always position quickfix window to the bottom
    au FileType qf wincmd J

    " Fold settings {
            set foldmethod=syntax	" automatically fold by syntax
            set nofoldenable	    " have folds open by default
            set foldlevel=99	    " prevent automatic folding unless we need to
    "}

    " Clipboard {
        if has('clipboard')
            if has('unnamedplus')  " When possible use + register for copy-paste
                set clipboard=unnamed,unnamedplus
            else         " On mac and Windows, use * register for copy-paste
                set clipboard=unnamed
            endif
        endif
    " }

    " GIT support {
        " Instead of reverting the cursor to the last position in the buffer, we
        " set it to the first line when editing a git commit message
        au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    " }
" }

 " Formatting {
        " Text wrap options (disable text-wrap) {
            set textwidth=0
            set wrapmargin=0
            set formatoptions-=t
            set nowrap
        "}

        " Format overrides based on file type
        "set tabstop=8 softtabstop=4 shiftwidth=4 smarttab cindent

        " Different tab settings per file type
        au Filetype html setl ts=2 sts=2 sw=2
        au Filetype yaml setl ts=2 sts=2 sw=2
        au Filetype apache setl ts=4 sw=4 sts=4 sr noet
        au FileType json setl ts=2 sts=2 sw=2
        au Filetype sls setl ts=2 sts=2 sw=2

        au FileType javascript setl sw=2 sts=2 et
        au FileType python set ts=4 sts=4 sw=4
        au FileType ruby set ts=2 sts=4 sw=2
        autocmd Filetype go setl ts=8 sts=8 sw=8
        autocmd Filetype rust setl ts=4 sts=4 sw=4

        " Automatically trim EOL whitespace when editing ruby/erlang code
        au FileType ruby autocmd BufWritePre * :%s/\s\+$//e
        au FileType erlang autocmd BufWritePre * :%s/\s\+$//e

        " Jenkinsfile
        au BufNewFile,BufRead Jenkinsfile setf groovy
        au FileType groovy set ts=4 sts=4 sw=4

" }

" Plugins {

     " airline {
        let g:airline_theme='onedark'                     " Use the kalisi theme!
        let g:airline_powerline_fonts=1                   " Enable powerline fonts.
        set noshowmode                                    " Don't show mode in command line.
        let g:airline#extensions#tabline#enabled=1        " Show the tabline.
        let g:airline#extensions#tabline#buffer_nr_show=1 " Show buffer numbers.
        let g:airline#extensions#tabline#show_tabs=0      " Don't show tabs in tabline.
     " }

     " black {
        let g:black_linelength = 100
        " Run Black on Python files on write.
        autocmd BufWritePost *.py execute ':Black'
     " }

     " deoplete {
        "  Deoplete default settings
        let g:deoplete#enable_at_startup = 1
     " }

     " Rust Lang {
        let g:rustfmt_autosave = 1
     " }

     " Go Lang {
        let g:go_fmt_command = "goimports"
     " }


     " NERDTree {
        " Automatically show NERDTree if no files are specified when
        " launching vim
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
        " Case-sensitive sorting
        let g:NERDTreeCaseSensitiveSort = 1
     " }
"}

" Keybindings {
    " Map leader to space
    let mapleader = "\<Space>"

    " Leader + w to save buffer
    nnoremap <Leader>w :w<CR>

    " Indentation shortcuts
    nnoremap <F5> mzgg=G`z
    au FileType json nnoremap <F5> :%!python -m json.tool<CR>

    " Toggle NERDTree
    map <leader>n :NERDTreeToggle<CR>

    " Toggle code comment ctrl + g
    nnoremap <silent><C-g> :call NERDComment("n", "Toggle")<CR>
    vnoremap <silent><C-g> :call NERDComment("x", "Toggle")<CR>

    " Make Page up/down work properly
    map <PageUp> <C-U>
    map <PageDown> <C-D>
    imap <PageUp> <C-O><C-U>
    imap <PageDown> <C-O><C-D>

    " Map jj to ESC when in insert mode
    inoremap jj <ESC>

    " Easier window switching
    " Note: iterm sends <BS> chen <C-h> is pressed. To fix go to preferences,
    " keys and add a mapping for C+h to Esc+ -> [104;5u
    nmap <silent> <C-h> :wincmd h<CR>
    nmap <silent> <C-j> :wincmd j<CR>
    nmap <silent> <C-k> :wincmd k<CR>
    nmap <silent> <C-l> :wincmd l<CR>
 "}}
