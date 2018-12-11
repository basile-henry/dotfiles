set nocompatible              " be iMproved, required
filetype off                  " required

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
call plug#begin('~/.vim/plugged')

" Colour scheme
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'

" Ack/Ag
Plug 'mileszs/ack.vim'

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-syntastic/syntastic'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
" Plug 'Shougo/neocomplete.vim'
" Plug 'Shougo/vimproc.vim'

" Haskell
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell' }
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim', 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', {'for': 'haskell' }
" Plug 'eagletmt/ghcmod-vim', {'for': 'haskell' }
" Plug 'nbouscal/vim-stylish-haskell', {'for': 'haskell' }

" Elm
Plug 'elmcast/elm-vim', {'for': 'elm' }

" Idris
Plug 'idris-hackers/idris-vim', {'for': 'idris' }

" Python
Plug 'davidhalter/jedi-vim', {'for': 'python' }

" Rust
Plug 'rust-lang/rust.vim', {'for': 'rust' }

" ReasonML
Plug 'reasonml-editor/vim-reason-plus', {'for': 'reasonml' }

" Nix
Plug 'LnL7/vim-nix', {'for': 'nix' }

" Racket
Plug 'wlangstroth/vim-racket'

" Nim
Plug 'zah/nim.vim', {'for': 'nim' }

call plug#end()

set termguicolors
set background=dark
syntax enable

set mouse=a
set timeoutlen=1000 ttimeoutlen=0
set encoding=utf-8
set cmdheight=1
set showcmd
set number
set nocompatible
" set nowrap
set tw=80
set ignorecase
set smartcase
set smarttab
set smartindent
set autoindent
set softtabstop=2
set shiftwidth=2
set expandtab
set incsearch
set hlsearch
set incsearch
set completeopt=menuone,menu,longest
set noshowmode
set dict+=/usr/share/dict/words
set thesaurus+=/usr/share/dict/thesaurus
set hidden

let mapleader=","

" Always show statusline
set laststatus=2

" Theme
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'one'
colorscheme one

map <Leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.o$', '\.hi$', '\.dyn.*$']

" CtrlP
let g:ctrlp_user_command = 'ag -i -l --nocolor -g "" %s'

" Ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

let g:NERDAltDelims_haskell = 1

" syntastic
map <Leader>s :SyntasticToggleMode<CR>

set statusline+=%{fugitive#statusline()}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntactic_rust_checkers = ['rustc']

" deoplete
let g:deoplete#enable_at_startup = 1

" supertab
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

" Haskell
let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
" Disable special indent handling
let g:haskell_indent_disable = 1

" Elm
let g:elm_format_autosave = 1
autocmd FileType elm setlocal shiftwidth=4 softtabstop=4

" Rust
let g:rustfmt_autosave = 1

hi MatchParen cterm=bold ctermbg=none ctermfg=none gui=bold

" augroup vimrc_autocmds
"   autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
"   autocmd BufEnter * match OverLength /\%81v.*/
" augroup END
