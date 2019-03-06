" {{{ Init configuration

set nocompatible
syntax on
filetype off

" Sets the working dir to the current one
autocmd BufEnter * silent! if bufname('%') !~# 'NERD_tree_' | lcd %:p:h | endif


" Vundle config
let g:vundle_default_git_proto = 'git'
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"}}}

" {{{ General options
" ---------------------- "

let mapleader = ","         " , as leader key

set wildignore+=*.o,*.run   " Ignore .o files
set wrap                    " Adjust lines to the window size (visually)
set encoding=utf-8          " utf-8
set t_Co=256                " 256 color terminal
set mouse=a                 " Enable the mouse
set showmatch               " Show matching brackets.
set ruler                   " Show the line and column numbers of the cursor
set ignorecase              " Do case insensitive matching
set incsearch               " Incremental search
set hlsearch                " highlight last search matches
set nobackup                " Don't keep a backup file
set number                  " Show line numbers
set modeline                " Configure file mode by a line at the beginning or the end

" folders {{{ data }}} :)
set foldenable
set foldmethod=marker
" Autocd to the directory of the file that its being edited
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" Selecting text in visual mode and hitting > indent text but also
" " deselect text.  Following remap will make sure text remains selected
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" suppress highlight of last search when hitting return
nnoremap <silent> <cr> :noh<cr>

" Default gvim font
if has('gui_running')
    set guifont=Monospace\ 12
    colorscheme slate
    " Disable bell and flashing
    set noerrorbells visualbell t_vb=
    if has('autocmd')
        autocmd GUIEnter * set visualbell t_vb=
    endif
endif

"}}}

"{{{ Addons
"
" Set markdown filetype when *.md file found
au BufRead,BufNewFile *.md set filetype=markdown
" Enable manpages from vim
runtime! ftplugin/man.vim

"}}}

" {{{ Other Options
" "----------------------------"

set tabstop=4                   " tab ==  4 spaces
set shiftwidth=4                " Use 4 spaces for indentation
set expandtab                   " enter spaces when tab is pressed
set softtabstop=4               " Backspace deletes 4 spaces
set smarttab                    " Use shiftwidth instead of tabstop at line start
set autoindent                  " Copy the indentation from the previous line
set smartcase                   " Override the 'ignorecase' option if the search pattern contains upper case characters
set shiftround                  " Round indent to multiple of shiftwidth
set showmode                    " If in Insert, Replace or Visual mode put a message on the last line
set shortmess=at                " Avoid 'hit Return' messages
set wildchar=<TAB>              " Use TAB as command expansion key
set wildmode=list:longest,full  " Completition mode. See :help wildmode

set list                        " Show special characters by default
set listchars=tab:>_,trail:<    " Use >_ for tabs and < for trails in list mode

set backspace=indent,eol,start  " Backspace behaviour. See :help 'backspace'

" }}}

"{{{ Appearance

" colorscheme
colorscheme desert

"}}}

" {{{ Functions

" Quick Open/Close 'copen'
command! -bang -nargs=? QFixToggle call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        if len(getqflist())
            "clast
        endif
        let g:qfix_win = bufnr("$")
    endif
endfunction

"}}}

"{{{ Key bindings
"---------------------"
" Info:
"   http://stackoverflow.com/questions/3776117/vim-what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-ma

" Autocmd que abre un fichero del location list en split horizontal arriba del
" todo y cierra el location list
autocmd FileType qf nmap <buffer> <cr> :to :wincmd F<cr><bar>:wincmd j<cr><bar>:lcl<cr>

" == Plugins ==

" File browser (NERDTree)
noremap <F3> :NERDTreeToggle<CR>
" Functions list (TagList)
map <F4> :Tlist<CR>
" Autoformat
noremap <F5> :Autoformat<CR><CR>
" Open an error window with the syntax errors from the compiler
noremap <F6> :call ToggleErrors()<CR>
" Open QuickFix
noremap <F7>  :QFixToggle<CR>
" Run C program
map <F8> :w <CR> :!gcc % -o %< && ./%< <CR>

" === Delete lines, words, without copying ===
nnoremap <leader>d "_d
nnoremap <leader>dd "_dd
nnoremap <leader>dw "_dw
nnoremap <leader>d$ "_d$

nnoremap <leader>c "_c
nnoremap <leader>cc "_cc
nnoremap <leader>cw "_cw
nnoremap <leader>c$ "_c$

" === Control buffer ===

" Quit without saving
cmap z q!
" : == ;
noremap ; :
" - == / (only for searches)
noremap - /

" == Tabs ===

" Open tab
nnoremap <C-n> :tabnew
" Next tab
noremap <C-h> :tabp<CR>
" Previous tab
nnoremap <C-l> :tabn<CR>
"" Close tab
nnoremap <C-U> <ESC>
"" remap ESC
inoremap jk <ESC>

"}}}

" {{{ PLUGINS VUNDLE
" ------------"

" Vundle manages itself
Plugin 'gmarik/Vundle.vim'
" Ack : Launch ack from vim -> Ack [options] {pattern} [{directory}]
Plugin 'mileszs/ack.vim'
" Full path fuzzy file, buffer, mru and tag finder for Vim
Plugin 'kien/ctrlp.vim'
"  GIT: Git wrapper
Plugin 'tpope/vim-fugitive'
" Statusline utility
Plugin 'Lokaltog/vim-powerline'
let g:Powerline_symbols = 'fancy'
set laststatus=2

Plugin 'matchit.zip'

" Add tags (or symbols) around the word
" http://www.catonmat.net/blog/vim-plugins-surround-vim/
Plugin 'surround.vim'

" Fixes a surround.vim bug that breaks the repeat command
"   http://www.catonmat.net/blog/vim-plugins-repeat-vim/
Plugin 'repeat.vim'

" Search, replace and abbreviate words
Plugin 'tpope/vim-abolish'

" Map comments
Plugin 'unimpaired.vim'

" ASM (GAS) syntax
Bundle 'vim-scripts/GNU-as-syntax'

" Visualize your Vim undo tree
"   http://sjl.bitbucket.org/gundo.vim/
Plugin 'sjl/gundo.vim'

" NERD Tree: Tree explorer plugin for vim
"   http://www.catonmat.net/blog/vim-plugins-nerdtree-vim/
Plugin 'scrooloose/nerdtree'

" PANDOC support
Plugin 'vim-scripts/RST-Tables'
Plugin 'vim-pandoc/vim-pandoc'

" List symbols of opened buffers
Plugin 'vim-scripts/taglist.vim'

" Utilities
Plugin 'duff/vim-scratch'
Plugin 'mattn/gist-vim'
Plugin 'mattn/pastebin-vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'godlygeek/tabular'

" Snipmate and dependencies
" Completes basic code
" https://github.com/garbas/vim-snipmate
" http://www.vim.org/scripts/script.php?script_id=2540
" https://github.com/honza/snipmate-snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'snipmate-snippets'
Plugin 'garbas/vim-snipmate'

" Comments
Plugin 'scrooloose/nerdcommenter'


" Autoformat
" https://github.com/Chiel92/vim-autoformat
Plugin 'Chiel92/vim-autoformat'
" -p : Add spaces between operators
" -c : Tabs to spaces
" -j : Add braces to all conditionals
" -s4: Tab == 4 spaces
let g:formatprg_c = 'astyle'
let g:formatprg_args_c = '--mode=c --style=kr -pcj -s4'

" easymotion
" https://github.com/Lokaltog/vim-easymotion
Plugin 'Lokaltog/vim-easymotion'

" AnsiEsc
" Ansi color codes to VIM hightlight
Plugin 'vim-scripts/AnsiEsc.vim'

" }}}


call vundle#end()
filetype plugin indent on

if filereadable(expand('~/.vim/Plugin/vim-misc/vimrc.vim'))
    source ~/.vim/bundle/vim-misc/vimrc.vim
endif
