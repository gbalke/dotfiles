"""" vundle install
let fresh_install=0
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
    let fresh_install=1
endif

"""" tab management
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
"" extra tabs for python
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab

autocmd FileType make setlocal noexpandtab

filetype off                  " required

" Save last position of cursor! (reloads when next opening the file)
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" set vim to chdir for each file
autocmd BufEnter * silent! lcd %:p:h

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set guifont=Liberation\ Mono\ for\ Powerline\ Regular\ 10"

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Fancy text colors
Plugin 'flazz/vim-colorschemes'

" Includes YCM underneath
Plugin 'zxqfl/tabnine-vim'

" Fancy footer/header
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Automated ctags generation for hopping around!
Plugin 'ludovicchabant/vim-gutentags'

" Highlights key words (from ctags)
Plugin 'vim-scripts/TagHighlight'

" Underline word under cursor
Plugin 'itchyny/vim-cursorword'

" Many language syntax support!
Plugin 'sheerun/vim-polyglot'

" History exploration
Plugin 'sjl/gundo.vim'

" Expanding directory navigation
Plugin 'scrooloose/nerdtree'

" Auto-search directories
Plugin 'kien/ctrlp.vim'

" Puts dots for spaces (indent)
Plugin 'Yggdroot/indentLine'

" Relative vs absolute line counts
Bundle "myusuf3/numbers.vim"

" " install plugins
if fresh_install == 1
    PluginInstall
endif
call vundle#end()

" Force syntax highlighting
au BufReadPost *.tex set syntax=context

" Extra Whitespace highlighting
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" Over line count coloring
highlight ColorColumn ctermbg=red guibg=red
"call matchadd('ColorColumn', '\%80v', 100)
set colorcolumn=80

colorscheme molokai

set laststatus=2
set ttimeoutlen=50
set scrolloff=5
" auto indent enable
set ai

syntax on

set path+=**
set wildmenu
set wildmode=longest:full,full

"""" arrow key remapping
nmap <silent> <Up> :exe "resize +5"<CR>
nmap <silent> <Down> :exe "resize -5"<CR>
nmap <silent> <Right> :exe "vert resize +5"<CR>
nmap <silent> <Left> :exe "vert resize -5"<CR>

""" NERDTree
nnoremap ,, :NERDTree<Return>
let g:NERDTreeShowHidden=1
let g:NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign = 'left'

""" Gutentags
let g:gutentags_ctags_tagfile = '.git/tags'
let g:gutentags_ctags_extra_args = [
    \ '--tag-relative=yes',
    \ '--fields=+ailmnS',
    \ ]
" let g:gutentags_cache_dir = '~/.cache/tags'

""" Ctrl+P
"let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

""" Tab dots
let g:indentLine_char = '·'
let g:indentLine_fileTypeExclude = ['json', 'markdown']
let g:indentLine_color_term=237

""" air-line
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
