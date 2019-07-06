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

set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab

autocmd FileType make set local noexpandtab

filetype off                  " required

" Save last position of cursor!
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" set vim to chdir for each file
autocmd BufEnter * silent! lcd %:p:h

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set guifont=Liberation\ Mono\ for\ Powerline\ Regular\ 10

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'flazz/vim-colorschemes'

Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'Yggdroot/indentLine'

Bundle "myusuf3/numbers.vim"
" The following are examples of different formats supported.

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Force syntax highlighting
au BufReadPost *.tex set syntax=context

" Extra Whitespace highlighting
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

colorscheme molokai

set laststatus=2
set ttimeoutlen=50
set scrolloff=5

""" You Complete Me
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

""" Tab dots
let g:indentLine_char = '·'
let g:indentLine_fileTypeExclude = ['json', 'markdown']
let g:indentLine_color_term=237

""" air-line
let g:airline_theme='jellybeans'
"'base16_monokai'
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
