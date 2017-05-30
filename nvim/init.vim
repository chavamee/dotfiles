" =================================
"             Globals
" =================================
runtime! archlinux.vim

filetype indent on
filetype plugin on
filetype on

let $GOBIN="/home/chavamee/.bin"

let mapleader=","

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
set laststatus=2
set autowrite
set clipboard=unnamedplus

set number
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set copyindent
set colorcolumn=+1
set cursorline cursorcolumn

set splitbelow
set splitright

set complete+=kspell

set diffopt+=vertical

set foldenable
set foldlevelstart=3
set foldmethod=syntax
set hidden
set cmdheight=2

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
    " Set all SCons files as python2
    autocmd BufRead,BufNewFile SCons* set filetype=python2
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

autocmd BufWritePre * StripWhitespace

" ==================================
"            Pluggins
" ==================================

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()

" === Formatting Plugins ===

Plug 'mattn/emmet-vim'

Plug 'junegunn/vim-easy-align'

Plug 'ConradIrwin/vim-bracketed-paste'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'ntpeters/vim-better-whitespace'

Plug 'tpope/vim-commentary'

Plug 'Raimondi/delimitMate'

Plug 'scrooloose/nerdcommenter'

" === Theme Plugins ===

Plug 'morhetz/gruvbox'

Plug 'powerline/powerline'

Plug 'vim-airline/vim-airline'

Plug 'mhinz/vim-startify'

" === Visual/Informative Plugins ===

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-fugitive'

" === Programming Languages Plugins ===

Plug 'sheerun/vim-polyglot'

" <<< Language Syntax/Formatting >>>
Plug 'jelera/vim-javascript-syntax', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp'}

Plug 'Mizuchi/STL-Syntax'

Plug 'plasticboy/vim-markdown', {'for': 'markdown'}

Plug 'rust-lang/rust.vim', {'for': 'rust'}

Plug 'arakashic/chromatica.nvim', {'do': function('DoRemote')}

" <<< Language Bundles >>>

Plug 'python-mode/python-mode', {'for': 'python'}

Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoInstallBinaries' }

" <<< Language Debug >>>

Plug 'scrooloose/syntastic'

Plug 'joonty/vdebug'

Plug 'tpope/vim-dispatch'

" <<< Language Autocomplete >>>

Plug 'racer-rust/vim-racer', {'for': 'rust'}

Plug 'nsf/gocode', {'for': 'go'}

Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

Plug 'zchee/deoplete-jedi', {'for': 'python'}

Plug 'zchee/deoplete-go', { 'do': 'make'}

Plug 'Rip-Rip/clang_complete', { 'for': 'cpp' }

" <<< Language Documentation >>>

Plug 'KabbAmine/zeavim.vim'

Plug 'honza/vim-snippets'

Plug 'sirver/UltiSnips'

" <<< Language Utilities >>>

Plug 'Shougo/context_filetype.vim'

Plug 'Shougo/neoinclude.vim'

Plug 'majutsushi/tagbar'

Plug 'xolox/vim-easytags'

Plug 'alepez/vim-gtest'

" === Navigation Plugins ===
Plug 'haya14busa/incsearch.vim'

Plug 'easymotion/vim-easymotion'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeTabsToggle' }

Plug 'jistr/vim-nerdtree-tabs'

Plug 'junegunn/fzf.vim'

" === Utilities ===

Plug 'tpope/vim-eunuch'

Plug 'xolox/vim-notes'

Plug 'mbbill/undotree'

Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

" === Misc ===

Plug 'xolox/vim-misc'

Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" ==================================
"               Theme
" ==================================

set termguicolors
set guifont=Hack

syntax enable
autocmd Syntax cpp call EnhanceCppSyntax()

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic=1
let g:load_doxygen_syntax='1'
let g:cpp_class_scope_highlight = 1
set background=dark

silent! colorscheme gruvbox

" ==================================
"       Plugin Configurations
" ==================================

let g:racer_cmd = "/usr/bin/racer_cmd"

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

endif

let g:delimitMate_expand_cr = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
let g:deoplete#enable_ignore_case = 'ignorecase'

let g:deoplete#sources#go#gocode_binary = '/usr/bin/gocode'
let g:deoplete#sources#go#use_cache = 1

" Only have c++ completion from clang_complete
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources.cpp = ['member']

"autocmd CmdwinEnter * let b:deoplete_sources = ['buffer']

set conceallevel=2
set concealcursor=vin

let g:clang_complete_auto = 0

let g:clang_use_library = 1

let g:UltiSnipsExpandTrigger="<C-j>"

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

let g:clang_library_path="/usr/lib/libclang.so"

let g:AutoPairsUseInsertedCount = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_enable_balloons = 1
let g:syntastic_aggregate_errors = 1

let g:syntastic_cpp_checkers = ["cppcheck", "clang_check", "clang_tidy"]
let g:syntastic_sh_checkers = ["sh", "bashate"]
let g:syntastic_javascript_checkers = ["jslint", "flow"]
let g:syntastic_json_checkers = ["jsonlint"]

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_check_header = 1

let g:syntastic_javascript_checkers = ['standard']

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" Vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_autosave = 1

" Python-mode
let g:pymode_rope_completion = 0
let g:pymode_python = 'python3'

" Powerline
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
nnoremap <F4> :NERDTreeTabsToggle <cr>

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

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc-vertical)
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap gd <Plug>(go-def-tab)
