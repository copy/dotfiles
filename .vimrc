execute pathogen#infect()

let g:python_host_prog = "/usr/bin/python2.7"
let g:python3_host_prog = "/usr/bin/python3"

if !has('nvim')
    " required for ocaml-vim to handle jumping between let/in etc.
    packadd! matchit
endif

set backspace=indent,eol,start

syntax enable
set virtualedit=block
set showcmd
set softtabstop=4 shiftwidth=4 expandtab
set nocompatible
set autoindent
"set smartindent " disabled, doesn't indent '#' in Python properly
set selectmode=mouse
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set number
set relativenumber
"set cursorline " disabled: screen noise
set mouse=a
set scrolloff=10
set nohidden " unload buffer when closing all tabs/splits with this buffer
"set synmaxcol=100
"set maxmempattern=100000
" jump to search results while typing search
set incsearch
" always show status bar
set laststatus=2
set ignorecase smartcase
set autoread
" open quickfix items in existing tab / new tab
set switchbuf=usetab,newtab
set splitright splitbelow

augroup focusgained
    autocmd!
    " Reload file if it hasn't changed in the buffer
    au FocusGained * :checktime
augroup END

if has('nvim')
    set inccommand=nosplit " show substitution live
endif

" For more: https://bluz71.github.io/2017/05/15/vim-tips-tricks.html
set breakindent
set showbreak=\\\\\

augroup vimresized
    autocmd!
    autocmd VimResized * wincmd =
augroup END

set wildmode=longest,list

set encoding=utf-8
set termencoding=utf-8

"set cc=100
" tw causes automatic wraps -- turns out to be painful in practice
"set cc=100 tw=100

filetype plugin indent on

if has('nvim')
    set dir=~/.nvimdir/
    set backupdir=~/.nvimbackup/
    set undodir=~/.nvimundo/
    set viminfo='10,\"100,:20,%,n~/.nviminfo
else
    set dir=~/.vimdir/
    set backupdir=~/.vimbackup/
    set undodir=~/.vimundo/
    set viminfo='10,\"100,:20,%,n~/.viminfo
endif

" store undos
set undofile
set undolevels=1000

set cmdheight=2

set hlsearch
set wildmenu

set title " Set terminal title (required for st)

" solarized theme
set background=dark

if 1
    colorscheme solarized
else
    set termguicolors
    colorscheme solarized8
endif

if has('gui_running')
  set guifont=Monospace\ 13
endif

" Show invisible characters
"set list

" don't fold sections
set foldmethod=manual
set nofoldenable


" allow ctrl+c, ctrl+v with x clipboard
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <C-p> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

map <silent> <cr> :noh<cr><c-cr>

" https://github.com/Shougo/deoplete.nvim/issues/492#issuecomment-306751415
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" show highlighting name for debugging highlight scripts
map <c-a-p> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" disable cursor keys
map <Left>  <nop>
map <Right> <nop>
map <Up>    <nop>
map <Down>  <nop>
imap <Left>  <nop>
imap <Right> <nop>
imap <Up>    <nop>
imap <Down>  <nop>
" remove ex mode
map Q <Nop>
" remove help
map <f1> <Nop>
imap <f1> <Nop>

" Search for selected text, forwards or backwards.
" In visual mode using * and #
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" n always moves forward
nnoremap <expr> n (v:searchforward ? 'n' : 'N')
nnoremap <expr> N (v:searchforward ? 'N' : 'n')

" tabs setup
map <c-j> :tabp<cr>
map <c-k> :tabn<cr>
"map <c-s-j> :tabmove -1<cr> " can't be mapped
"map <c-s-k> :tabmove +1<cr>
map <c-l> <c-w>w
"map <c-h> <c-w>W
imap <c-j> <ESC><c-j>
imap <c-k> <ESC><c-k>
imap <c-l> <ESC><c-l>
"imap <c-h> <ESC><c-h>
imap <c-t> <ESC><c-t>
if has('nvim')
    tmap <c-j> <ESC><c-j>
    tmap <c-k> <ESC><c-k>
    tmap <c-t> <ESC><c-t>
    tmap <c-l> <ESC><c-l>
endif

" open file/url under cursor in new tab
nnoremap gf <C-W>gf
vnoremap gf <C-W>gf

function! RestoreCursor()
    if &ft != 'gitcommit' && line("'\"") > 1 && line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction
augroup resCur
    autocmd!
    autocmd BufWinEnter * call RestoreCursor()
augroup END

augroup autoAleLint
    autocmd!
    autocmd TabEnter,FocusGained,TextChanged,InsertLeave,FocusLost * silent! ALELint
augroup END
"let g:ale_open_list = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_lint_on_text_changed = 'never'
let g:ale_jshint_config_loc = "/home/fabian/.jshint-vim.json"
let g:ale_c_clang_options = '-Wall -std=c11 -Wno-bitwise-op-parentheses -Wno-gnu-binary-literal'
let g:ale_c_clangtidy_options = '-Wall -std=c11 -Wno-bitwise-op-parentheses -Wno-gnu-binary-literal'
let g:ale_python_mypy_options = '--ignore-missing-imports --check-untyped-defs --disallow-untyped-calls --warn-return-any --no-implicit-optional --cache-dir /home/fabian/.cache/mypy'
let g:ale_maximum_file_size = 1000000
" TODO: clangtidy
let g:ale_linters = {
\   'c': ['clang'],
\   'cpp': ['clang'],
\   'python': ['mypy'],
\   'javascript': ['jshint'],
\   'asm': [],
\}


if !empty(glob(getcwd() . "/bsconfig.json")) || !empty(glob(expand('%:p:h') . "/bsconfig.json"))
    let g:opamshare = substitute(system('OPAMSWITCH=4.02.3+buckle-master opam config var share'),'\n$','','''')
    autocmd BufWritePre,BufWritePost,BufEnter * let b:merlin_path = "/home/fabian/.opam2/4.02.3+buckle-master/bin/ocamlmerlin"
    "let g:merlin = {'ocamlmerlin_path': '/home/fabian/.opam2/4.02.3+buckle-master/bin/ocamlmerlin'}
else
    let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
end
if v:shell_error == 0
    execute "set rtp+=" . g:opamshare . "/merlin/vim"
    execute "set rtp^=" . g:opamshare . "/ocp-indent/vim"
end

augroup setup_ocaml
    autocmd!
    autocmd Filetype ocaml call SetOcamlOptions()
augroup END
function! SetOcamlOptions()

    highlight link ALEError Error
    highlight link ALEWarning Error

    let g:merlin_ignore_warnings = 'true'

    "let g:merlin_display_occurrence_list = 0
    "nmap <LocalLeader>*  <Plug>(MerlinSearchOccurrencesForward)

    " should be never when using buffers instead of tabs
    let g:merlin_split_method = "tab"
    "let g:merlin_completion_arg_type = "always"
    let g:merlin_completion_arg_type = "never"
    let g:merlin_completion_with_doc = "true"

    let g:deoplete#auto_complete_delay = 0

    "let g:deoplete#enable_profile = 1
    "call deoplete#enable_logging('DEBUG', '/tmp/deoplete.log')
    "call deoplete#custom#source('ocaml', 'debug_enabled', 1)

    function! ToggleOccurences()
        let old_last_winnr = winnr('$')
        lclose
        if old_last_winnr == winnr('$')
            " Nothing was closed, open syntastic error location panel
            MerlinOccurrences
        endif
    endfunction

    " This fixes `MerlinTypeOf` not working on a message with an error shown
    " by ALE, but disables highlighting of the type
    "let g:merlin_type_history_height = 0

    " This also fixes the problem
    let g:merlin_type_history_auto_open = 0

    "noremap <f4> :MerlinILocate<cr>
    noremap <f4> :MerlinDocument<cr>
    noremap <f3> :MerlinLocate<cr>
    noremap <f2> :MerlinTypeOf<cr>
    vnoremap <f2> <esc>:'<,'>:MerlinTypeOfSel<cr>gv
    noremap <f5> :MerlinOutline<cr>
    "noremap <f5> :FZFMerlinOutline<cr>
    "noremap <f6> :let g:syntastic_auto_loc_list = 0<cr>:MerlinOccurrences<cr>
    noremap <f6> :call ToggleOccurences()<cr>
    noremap <f7> :MerlinToggleTypeHistory<cr><c-w>w

    setlocal softtabstop=2 shiftwidth=2
    setlocal autowrite
    setlocal iskeyword+=`

    function! JbuilderTest()
        "setlocal errorformat=%E%f\ line\ %l\ in\ %m,%C%m,%Z
        setlocal errorformat=File\ \"%f\"\\,\ line\ %l\\,\ characters\ %c-%*\\d:\ %m
        "setlocal errorformat+=%*[\ ]%m\ \"%f\"\\,\ line\ %l\\,\ characters\ %c-%*\\d
        setlocal makeprg=jbuilder
        make runtest
        copen
        "Dispatch jbuilder runtest
    endfunction

    command! MerlinLocateIntf call Merlin_locate_intf()

    function! Merlin_locate_intf()
        let g:merlin_locate_preference = 'mli'
        MerlinLocate
        let g:merlin_locate_preference = 'ml'
    endfunction

    command! Exec call Exec()

    function! Exec()
        execute "!jbuilder exec ./" . expand("%:r") . ".exe"
    endfunction

    " TODO: Make use of nvim's terminal for tests and compilation
endfunction

augroup vimrc
    autocmd!

    " Maps Coquille commands to <F2> (Undo), <F3> (Next), <F4> (ToCursor)
    autocmd FileType coq call coquille#FNMapping()
    autocmd FileType coq setlocal iskeyword+='

    " Close scratch window automatically
    autocmd CompleteDone * pclose

    autocmd FileType python map <buffer> <f5> :!./%<enter>
    autocmd FileType python map <buffer> <f3> <leader>g
    autocmd FileType python map <buffer> <f4> <leader>n

    autocmd BufNewFile,BufRead *.ejs set filetype=javascript
augroup END

augroup Binary
    autocmd!
    autocmd BufReadPre  *.bin let &bin=1
    autocmd BufReadPost *.bin if &bin | %!xxd -g 1
    autocmd BufReadPost *.bin set ft=xxd | endif
    autocmd BufWritePre *.bin if &bin | %!xxd -r
    autocmd BufWritePre *.bin endif
    autocmd BufWritePost *.bin if &bin | %!xxd -g 1
    autocmd BufWritePost *.bin set nomod | endif
augroup END

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }
"let g:ctrlp_map = '<c-t>'
let g:ctrlp_map = '<nop>'

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|\.o$\|_build\/\|.pyc$\|.png$'
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_root_markers = [".merlin"]

" Use regexp mode instead of fuzzy
let g:ctrlp_regexp = 1

let g:fzf_action = {
  \ 'ctrl-t': '',
  \ 'enter': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=* RgFZF
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

let g:fzf_buffers_jump = 1

nmap <c-t> :FZF<cr>
nmap <c-b> :Windows<cr>

" neovim specific stuff
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <c-\> <Esc>
    nnoremap <c-\> i<Esc><c-\><c-n>
    noremap <f7> :tabe<cr>:term<cr>

    function! UndoEscMappingFzf()
        if exists('b:fzf')
            tnoremap <buffer> <Esc> <Esc>
        endif
    endfunction

    augroup terminal
        autocmd!
        autocmd TermOpen * setlocal number relativenumber
        autocmd BufEnter term://* startinsert
        autocmd TermOpen term://* startinsert
        autocmd TermOpen term://* call UndoEscMappingFzf()
    augroup END
    command! TT :tabe | :term
    command! Test :tabe | :term jbuilder runtest
endif

" Exclude quickfix list from buffers
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END

augroup templates
    autocmd!
    autocmd BufNewFile jbuild silent! 0r $HOME/ocaml/templates/jbuild.template
    autocmd BufNewFile opam* silent! 0r $HOME/ocaml/templates/opam.template
augroup END

if exists("vimpager")
    " less.vim is annoying since it can't select text
    let g:less = { 'enabled': 0 }
    " emulate the useful less.vim features
    noremap <buffer> d <C-d>
    noremap <buffer> u <C-u>
    noremap <buffer> q :q<cr>
    " Prevent delay when pressing d https://github.com/rkitover/vimpager/issues/131
    "let g:loaded_surround = 1

    " yanking shouldn't include colour escapes, use built-in highlighting
    " this breaks word-diff highlighting
    let g:vimpager.ansiesc = 0
endif


let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_smart_case = 0
let g:deoplete#max_menu_width = 62
let g:deoplete#max_abbr_width = 60
let g:deoplete#max_list = 0

let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources.ocaml = ['buffer', 'around', 'member', 'tag']
let g:deoplete#ignore_sources._ = ['tag']

let g:GPGUseAgent = 0
let g:GPGPreferSymmetric = 1


" Highlight trailing whitespace
"highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+\%#\@<!$/
highlight ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" the above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" the default is too similar to diff's red, reset it
autocmd FileType diff highlight diffSubname ctermfg=Gray

" Highlight character at column 100
highlight ColorColumn ctermbg=darkred
call matchadd('ColorColumn', '\%101v', 500)
