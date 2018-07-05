set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-airline/vim-airline'
Plugin 'matze/vim-move'
" Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-syntastic/syntastic'
" Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/vimproc.vim'


" Haskell as describe http://www.stephendiehl.com/posts/vim_2016.html
Plugin 'eagletmt/ghcmod-vim'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'nbouscal/vim-stylish-haskell'
Plugin 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
" Plugin 'eagletmt/neco-ghc'

" Elm
Plugin 'elmcast/elm-vim'

" Idris
Plugin 'idris-hackers/idris-vim'

" Colour scheme
" Plugin 'arcticicestudio/nord-vim'
Plugin 'rakr/vim-one'

" Python
Plugin 'davidhalter/jedi-vim'

" Rust
Plugin 'rust-lang/rust.vim'

" ReasonML
Plugin 'reasonml-editor/vim-reason-plus'

" Nix
Plugin 'LnL7/vim-nix'

" CtrlP
Plugin 'ctrlpvim/ctrlp.vim'

" Ack/Ag
Plugin 'mileszs/ack.vim'

" Racket
Plugin 'wlangstroth/vim-racket'

" Nim
Plugin 'zah/nim.vim'

call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set termguicolors
syntax enable

set background=dark

set mouse=a
set timeoutlen=1000 ttimeoutlen=0
set encoding=utf-8
set cmdheight=1
set showcmd
set number
set relativenumber
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
set clipboard+=unnamedplus
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

" Vim move
let g:move_key_modifier = 'C'

" GitGutter styling to use · instead of +/-
" let g:gitgutter_sign_added = '∙'
" let g:gitgutter_sign_modified = '∙'
" let g:gitgutter_sign_removed = '∙'
" let g:gitgutter_sign_modified_removed = '∙'

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

" ghc-mod
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

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
" autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
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

augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%81v.*/
augroup END
