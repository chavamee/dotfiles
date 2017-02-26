runtime! archlinux.vim

filetype indent on
filetype plugin on
filetype on

function! EnhanceCppSyntax()
  syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
  hi def link cppFuncDef Special
endfunction

" ==================================
"             Formatting
" ==================================

set nobackup
set nowritebackup
set noswapfile
set ruler
set showcmd
set showmatch
set wildmenu
set incsearch
set hlsearch
set ignorecase
set smartcase
set hidden
set laststatus=2 " Always show statusline
set autowrite
set clipboard=unnamedplus " Yank goes to clipboard as well

set number
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line"
set colorcolumn=+1
set cursorline cursorcolumn

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd BufRead,BufNewFile *.md set filetype=markdown
  " Set all SCons files as python
  autocmd BufRead,BufNewFile SCons* set filetype=python
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  " autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  autocmd FileType javascript setlocal shiftwidth=2
  autocmd BufRead,BufNewFile *.pug setlocal shiftwidth=2
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

set wildmode=list:longest,list:full

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

set foldenable
"set foldlevelstart=10
"set foldnestmax=10
set foldmethod=syntax

set hidden
set cmdheight=2

autocmd BufWritePre * StripWhitespace

" ==================================
"            Pluggins
" ==================================

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()

Plug 'morhetz/gruvbox'

Plug 'powerline/powerline'

Plug 'vim-airline/vim-airline'

Plug 'junegunn/vim-easy-align'

Plug 'scrooloose/syntastic'

Plug 'pangloss/vim-javascript'

Plug 'jelera/vim-javascript-syntax'

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

Plug 'joonty/vdebug'

Plug 'honza/vim-snippets'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }

Plug 'junegunn/fzf.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'mhinz/vim-signify'

Plug 'ConradIrwin/vim-bracketed-paste'

Plug 'sirver/UltiSnips'

Plug 'xolox/vim-easytags'

Plug 'tpope/vim-dispatch'

Plug 'python-mode/python-mode'

Plug 'racer-rust/vim-racer'

Plug 'wellle/tmux-complete.vim'

Plug 'Shougo/context_filetype.vim'

Plug 'Shougo/neoinclude.vim'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'ntpeters/vim-better-whitespace'

Plug 'haya14busa/incsearch.vim'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-eunuch'

Plug 'easymotion/vim-easymotion'

Plug 'mhinz/vim-startify'

Plug 'xolox/vim-notes'

Plug 'KabbAmine/zeavim.vim'

Plug 'xolox/vim-misc'

Plug 'jiangmiao/auto-pairs'

Plug 'mbbill/undotree'

Plug 'nsf/gocode'

Plug 'majutsushi/tagbar'

Plug 'alepez/vim-gtest'

Plug 'rust-lang/rust.vim'

Plug 'sheerun/vim-polyglot'

Plug 'suan/vim-instant-markdown'

Plug 'plasticboy/vim-markdown'
" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'Mizuchi/STL-Syntax'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'scrooloose/nerdcommenter'

Plug 'carlitux/deoplete-ternjs'

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

Plug 'zchee/deoplete-jedi'

Plug 'zchee/deoplete-go', { 'do': 'make'}

Plug 'Rip-Rip/clang_complete'

call plug#end()

" ==================================
"               Theme
" ==================================

set termguicolors
set guifont=Hack

syntax enable
autocmd Syntax cpp call EnhanceCppSyntax()

let g:gruvbox_contrast_dark='hard'
let g:load_doxygen_syntax='1'
let g:cpp_class_scope_highlight = 1
set background=dark

silent! colorscheme gruvbox

" ==================================
"       Plugin Configurations
" ==================================

let g:racer_cmd = "/usr/bin/racer_cmd"
let $RUST_SRC_PATH="/usr/src/rust/src"

let mapleader=","

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

endif

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

set completeopt+=noselect
set omnifunc=syntaxcomplete#Complete
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
let g:deoplete#enable_ignore_case = 'ignorecase'
let g:deoplete#sources#go#gocode_binary = '/usr/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1

autocmd CmdwinEnter * let b:deoplete_sources = ['buffer']

set conceallevel=2
set concealcursor=vin

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'

" Complete options (disable preview scratch window, longest removed to aways
" show menu)
set completeopt=menu,menuone

" Limit popup menu height
set pumheight=20

let g:easytags_cmd='/usr/bin/ctags'
let g:easytags_suppress_ctags_warning = 1
let g:easytags_suppress_report = 1
"let g:easytags_autorecurse = 1

let g:clang_library_path="/usr/lib/libclang.so"

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_enable_balloons = 1
let g:syntastic_aggregate_errors = 1

"let g:syntastic_python_checkers = ['python', 'flake8', 'pep8', 'pyflakes', 'pylint']
let g:syntastic_cpp_checkers = ["cppcheck", "clang_check", "clang_tidy"]
let g:syntastic_sh_checkers = ["sh", "bashate"]
let g:syntastic_javascript_checkers = ["jslint", "flow"]
let g:syntastic_json_checkers = ["jsonlint"]

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_check_header = 1

let g:syntastic_javascript_checkers = ['standard']

let g:syntastic_go_checkers = ['go', 'gofmt']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" Vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_autosave = 1

" Powerline
let $PYTHONPATH="/usr/lib/python3.3/site-packages"
let g:Powerline_symbols = 'fancy'

" Vim-airline
let g:airline_powerline_fonts = 1
let g:airline_section_y = ''
let g:airline_section_warning = ''

let g:airline_mode_map = {
            \ '__' : '-',
            \ 'n'  : 'N',
            \ 'i'  : 'I',
            \ 'R'  : 'R',
            \ 'c'  : 'C',
            \ 'v'  : 'V',
            \ 'V'  : 'V',
            \ '' : 'V',
            \ 's'  : 'S',
            \ 'S'  : 'S',
            \ '' : 'S',
            \ }

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_error=''

let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1

function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" ==================================
"            Keybindings
" ==================================

nnoremap <c-p> :FZF <cr>

noremap <F2> :lnext <cr>
noremap <F3> :lprevious <cr>

" NERDtree
nnoremap <F4> :NERDTreeToggle <cr>

" UndoTree
nnoremap <F6> :UndotreeToggle <cr>

" Spell check
noremap <F7> :setlocal spell! spelllang=en_us<cr>

" Tagbar
nmap <F8> :TagbarToggle <cr>

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

nnoremap <Left>  :echoe "Use h"<cr>
nnoremap <Right> :echoe "Use l"<cr>
nnoremap <Up>    :echoe "Use k"<cr>
nnoremap <Down>  :echoe "Use j"<cr>

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

imap     <Nul> <C-Space>
inoremap <expr><C-Space> deoplete#mappings#manual_complete()
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

