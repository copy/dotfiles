set t_ut=

if !has('nvim')
    set runtimepath^=~/.config/vim
endif

let g:python_host_prog = '/usr/bin/python2.7'
let g:python3_host_prog = '/usr/bin/python3'

if !has('nvim')
    " required for ocaml-vim to handle jumping between let/in etc.
    packadd! matchit
endif

set backspace=indent,eol,start

syntax enable
set virtualedit=block
set showcmd
set softtabstop=4 shiftwidth=4 expandtab
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

"augroup kernel
"    autocmd!
"    au FileType c setlocal noexpandtab shiftwidth=8 softtabstop=8 tabstop=8
"    au FileType cpp setlocal noexpandtab shiftwidth=8 softtabstop=8 tabstop=8
"augroup END

augroup golang
    autocmd!
    au FileType go setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
augroup END

if has('nvim')
    set inccommand=nosplit " show substitution live
endif

" For more: https://bluz71.github.io/2017/05/15/vim-tips-tricks.html
set breakindent
set showbreak=↪

set wildmode=longest,list

set encoding=utf-8
set termencoding=utf-8

set clipboard=unnamedplus

"set cc=100
" tw causes automatic wraps -- turns out to be painful in practice
"set cc=100 tw=100

filetype plugin indent on

set nobackup nowritebackup

if has('nvim')
    set directory=~/.cache/nvimdir/
    "set backupdir=~/.cache/nvimbackup/
    set undodir=~/.cache/nvimundo/
    set viminfo='10,\"100,:20,%,n~/.cache/nviminfo
else
    set directory=~/.cache/vimdir/
    "set backupdir=~/.cache/vimbackup/
    set undodir=~/.cache/vimundo/
    set viminfo='10,\"100,:20,%,n~/.cache/viminfo
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

if 0
    "colorscheme solarized
else
    set termguicolors
    let g:solarized_diffmode = 'high'

    try
        colorscheme solarized8_flat
    catch /^Vim\%((\a\+)\)\=:E185/
    endtry

    " git diff not handled by vim-solarized8
    hi def link diffAdded DiffAdd
    hi def link diffRemoved DiffDelete

    " Remove background
    hi TabLine ctermfg=247 ctermbg=236 guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi TabLineFill ctermfg=247 ctermbg=236 guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    " slightly brighter than the default (#586e75)
    hi Comment ctermfg=242 ctermbg=NONE guifg=#6e8991 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
endif

if has('gui_running')
  set guifont=Monospace\ 13
endif

" Show invisible characters
"set list

" don't fold sections
set foldmethod=manual
set nofoldenable

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
map q: <Nop>
" remove help
map <f1> <Esc>
imap <f1> <Esc>

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

map <F25> :1tabn<cr>
map <F26> :2tabn<cr>
map <F27> :3tabn<cr>
map <F28> :4tabn<cr>
map <F29> :5tabn<cr>

imap <F25> <esc>:1tabn<cr>
imap <F26> <esc>:2tabn<cr>
imap <F27> <esc>:3tabn<cr>
imap <F28> <esc>:4tabn<cr>
imap <F29> <esc>:5tabn<cr>

tmap <F25> <esc>:1tabn<cr>
tmap <F26> <esc>:2tabn<cr>
tmap <F27> <esc>:3tabn<cr>
tmap <F28> <esc>:4tabn<cr>
tmap <F29> <esc>:5tabn<cr>

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
    if &filetype !=# 'gitcommit' && line("'\"") > 1 && line("'\"") <= line('$')
        normal! g`"
        return 1
    endif
endfunction
augroup resCur
    autocmd!
    autocmd BufWinEnter * call RestoreCursor()
augroup END

augroup focusgained
    autocmd!
    " Reload file if it hasn't changed in the buffer
    au FocusGained * :checktime
augroup END

augroup vimresized
    autocmd!
    autocmd VimResized * wincmd =
augroup END

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

augroup wast
    autocmd!
    autocmd BufReadPost *.wast set ft=lisp
augroup END

" Exclude quickfix list from buffers
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END

" Rust
augroup rust2
    autocmd!
    autocmd Filetype rust call SetRustOptions()
augroup END
function! SetRustOptions()
    "let b:ale_lint_on_insert_leave = 0
    let b:ale_lint_on_text_changed = 'never'
    "nmap <buffer> <f2> <plug>DeopleteRustShowDocumentation
    "nmap <buffer> <f3> <plug>DeopleteRustGoToDefinitionDefault
    "nmap <buffer> <f2> <plug>DeopleteRustShowDocumentation
    "nmap <buffer> <f2> :ALEGoToTypeDefinition<cr>
    nmap <buffer> <f2> :ALEHover<cr>
    nmap <buffer> <f3> :ALEGoToDefinition<cr>
    nmap <buffer> <f4> :ALEFindReferences<cr>

    " Deoplete somehow causes ALE to be triggered in insert mode
    " https://github.com/dense-analysis/ale/issues/3105
    "call deoplete#custom#buffer_option('auto_complete', v:false)

    augroup rust
        autocmd!
        "autocmd BufWritePre * undojoin | Neoformat
        autocmd BufWritePre *.rs try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
    augroup END
endfunction

augroup templates
    autocmd!
    autocmd BufNewFile dune silent! 0r $HOME/ocaml/templates/dune.template
    autocmd BufNewFile opam* silent! 0r $HOME/ocaml/templates/opam.template
    autocmd BufNewFile *.sh silent! 0r $HOME/.config/shell.template | normal j
augroup END

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
if v:shell_error == 0
    execute 'set rtp+=' . g:opamshare . '/merlin/vim'
    execute 'set rtp^=' . g:opamshare . '/ocp-indent/vim'
end

augroup setup_ocaml
    autocmd!
    autocmd Filetype ocaml call SetOcamlOptions()
augroup END
function! SetOcamlOptions()
    "highlight ocamlComment ctermfg=white guifg=white
    "highlight link ocamlComment NONE

    let g:ocaml_highlight_operators = 1

    let g:merlin_ignore_warnings = 'false'

    command! MerlinToggleWarnings if g:merlin_ignore_warnings == 'true' | let g:merlin_ignore_warnings = 'false' | ALELint | else | let g:merlin_ignore_warnings = 'true' | ALELint | end

    "let g:merlin_display_occurrence_list = 0
    "nmap <LocalLeader>*  <Plug>(MerlinSearchOccurrencesForward)

    " should be never when using buffers instead of tabs
    let g:merlin_split_method = 'tab'
    "let g:merlin_completion_arg_type = "always"
    let g:merlin_completion_arg_type = 'never'
    "let g:merlin_completion_with_doc = "true" " Note: https://github.com/ocaml/merlin/issues/726

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
    "let g:merlin_type_history_auto_open = 0

    "noremap <buffer> <f4> :MerlinILocate<cr>
    noremap <buffer> <f4> :MerlinDocument<cr>
    noremap <buffer> <f3> :MerlinLocate<cr>
    noremap <buffer> <f2> :MerlinTypeOf<cr>
    vnoremap <buffer> <f2> <esc>:'<,'>:MerlinTypeOfSel<cr>gv
    noremap <buffer> <f5> :MerlinLocateIntf<cr>
    noremap <buffer> <f1> :FZFMerlinOutline<cr>
    "noremap <buffer> <f6> :let g:syntastic_auto_loc_list = 0<cr>:MerlinOccurrences<cr>
    noremap <buffer> <f6> :call ToggleOccurences()<cr>
    noremap <buffer> <f7> :MerlinToggleTypeHistory<cr><c-w>w

    setlocal softtabstop=2 shiftwidth=2
    setlocal autowrite

    " Don't add leading * to multiline comments, i.e. do this:
    " (* foo
    "    bar *)
    " but not:
    " (* foo
    "  * bar *)
    setlocal formatoptions-=c formatoptions-=o formatoptions-=r

    function! DuneTest()
        "setlocal errorformat=%E%f\ line\ %l\ in\ %m,%C%m,%Z
        setlocal errorformat=File\ \"%f\"\\,\ line\ %l\\,\ characters\ %c-%*\\d:\ %m
        "setlocal errorformat+=%*[\ ]%m\ \"%f\"\\,\ line\ %l\\,\ characters\ %c-%*\\d
        setlocal makeprg=dune
        make runtest
        copen
        "Dispatch dune runtest
    endfunction

    command! MerlinLocateIntf call Merlin_locate_intf()

    function! Merlin_locate_intf()
        let g:merlin_locate_preference = 'mli'
        MerlinLocate
        let g:merlin_locate_preference = 'ml'
    endfunction

    command! Exec call Exec()

    function! Exec()
        execute '!dune exec ./' . expand('%:r') . '.exe'
    endfunction

    " TODO: Make use of nvim's terminal for tests and compilation

    function! MaybeALELint()
        if expand('%:t') !=# ':merlin-type-history:'
            ALELint
        end
    endfunction

    augroup autoAleLint
        autocmd!
        autocmd TabEnter,FocusGained,TextChanged,InsertLeave,FocusLost * silent! call MaybeALELint()
    augroup END
endfunction

augroup dune2
    autocmd!
    autocmd Filetype dune call SetDuneOptions()
augroup END
function! SetDuneOptions()
    augroup dune
        autocmd!
        autocmd BufWritePre dune try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
    augroup END
endfunction

augroup typescript2
    autocmd!
    autocmd Filetype typescript call SetTypescriptOptions()
augroup END
function! SetTypescriptOptions()
    augroup typescript
        autocmd!
        autocmd BufWritePre *.ts try | undojoin | Neoformat prettier | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat prettier | endtry
    augroup END
endfunction


"command! AutoWrite autocmd TextChanged,InsertLeave <buffer> silent! update | ALELint
command! AutoWrite autocmd TextChanged,InsertLeave <buffer> try | undojoin | silent! update | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent! update | endtry
command! AutoWriteAllTabs autocmd TextChanged,InsertLeave try | undojoin | silent! update | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent! update | endtry

augroup autowrite
    autocmd!
    autocmd Filetype ocaml AutoWrite
    autocmd Filetype markdown AutoWrite
    "autocmd Filetype text AutoWrite " password.gpg file
    autocmd Filetype dune AutoWrite
    autocmd Filetype vim AutoWrite
    autocmd Filetype python AutoWrite
    autocmd Filetype plaintex AutoWrite
    autocmd Filetype agda AutoWrite
    autocmd Filetype haskell AutoWrite
    autocmd Filetype k AutoWrite
augroup END

let g:ale_completion_enabled = 0
"let g:ale_open_list = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
"let g:ale_lint_on_filetype_changed = 1
let g:ale_jshint_config_loc = glob('~/.config/jshint.json')
let g:ale_c_clang_options = '-Wall -std=c11 -Wno-bitwise-op-parentheses -Wno-gnu-binary-literal'
let g:ale_c_clangtidy_options = '-Wall -std=c11 -Wno-bitwise-op-parentheses -Wno-gnu-binary-literal'
let g:ale_python_mypy_options = '--ignore-missing-imports --check-untyped-defs ' .
            \'--disallow-untyped-calls --warn-return-any --no-implicit-optional ' .
            \glob('--cache-dir ~/.cache/mypy')
let g:ale_maximum_file_size = 1000000
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_delay = 0
let g:ale_echo_cursor = 0 " interferes with MerlinTypeOf
let g:ale_html_htmlhint_options = '--config ~/.config/htmlhint.conf'
let g:ale_hover_cursor = 0 " laggy
let g:ale_rust_analyzer_config = { 'diagnostics': { 'disabled': ['incorrect-ident-case', 'inactive-code'] } }
"g:ale_virtualtext_prefix
let g:ale_linters = {
\   'c': ['clang'],
\   'cpp': ['clang'],
\   'javascript': ['jshint'],
\   'python': ['pyflakes', 'mypy'],
\   'asm': [],
\   'rust': ['analyzer'],
\   'java': [],
\   'haskell': ['hie', 'hlint'],
\   'json': ['jsonlint'],
\   'go': ['golint', 'gofmt'],
\   'ocaml': ['merlin'],
\}

hi Error guifg=#dc322f guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi ALEError guifg=#dc322f guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi ALEWarning guifg=#dc322f guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi ALEErrorSign guifg=#dc322f guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi ALEWarningSign guifg=#dc322f guibg=NONE guisp=NONE gui=NONE cterm=NONE

let g:merlin_disable_default_keybindings = 1 " otherwise merlin takes \n and \p
nmap <silent> <Leader>p <Plug>(ale_previous_wrap)
nmap <silent> <Leader>n <Plug>(ale_next_wrap)

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
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
            " Otherwise fzf hangs with 100% cpu usage
            tnoremap <buffer> <c-t> <Esc> <Esc>
        endif
    endfunction

    augroup terminal
        autocmd!
        autocmd TermOpen * setlocal nonumber norelativenumber
        autocmd BufEnter term://* startinsert
        autocmd TermOpen term://* startinsert
        autocmd TermOpen term://* call UndoEscMappingFzf()
    augroup END
    command! TT :tabe | :term
    command! VT :vs | :term
    command! HT :hs | :term

    command! Test :tabe | :term dune runtest
    command! Run execute ":tabe | :term dune exec ./" . (system("dune_run.exe " . expand("%:t")))
    command! Build execute ":tabe | :term dune build -w ./" . (system("dune_run.exe " . expand("%:t")))
    "command! Build execute ":tabe | :term dune build -w ./" . expand("%:r") . ".exe"
endif

command! TS :tab split

set runtimepath+=~/.config/nvim/pack/plugins/start/deoplete.nvim
let g:deoplete#enable_at_startup = 1

try
    call deoplete#custom#option('enable_ignore_case', 0)
    call deoplete#custom#option('enable_smart_case', 0)
    call deoplete#custom#option('max_menu_width', 62)
    call deoplete#custom#option('max_abbr_width', 60)
    call deoplete#custom#option('max_list', 0)
    "let g:deoplete#enable_ignore_case = 0
    "let g:deoplete#enable_smart_case = 0
    "let g:deoplete#max_menu_width = 62
    "let g:deoplete#max_abbr_width = 60
    "let g:deoplete#max_list = 0

    call deoplete#custom#option('ignore_sources', { 'ocaml': ['buffer', 'around', 'member', 'tag'] })
    call deoplete#custom#option('ignore_sources', { 'rust': ['buffer', 'around', 'member', 'tag'] })
    " The following enables synchronous omnibuffer completion
    "let g:deoplete#omni#input_patterns.ocaml = '[^. *\t]\.\w*|\s\w*|#'

    call deoplete#custom#option('auto_complete_delay', 0)
    "let g:deoplete#auto_complete_delay = 0
    "call deoplete#custom#option('sources', {
    "            \ 'rust': ['ale'],
    "            \})
    "set omnifunc=ale#completion#OmniFunc
catch /^Vim\%((\a\+)\)\=:E117/
endtry

let g:GPGUseAgent = 0
let g:GPGPreferSymmetric = 1

" Highlight character at column 100 and trailing spaces
" TODO: Also after :tab split
hi Bangy guibg=#2824b4 ctermbg=blue
augroup bangy
    autocmd!
    autocmd BufWinEnter {makefile,Makefile,*.{ml,mli,c,h,ts,rs,js,html,css,py,go,sh,k,vim,hs}} match Bangy /\%100v.\|\s\+$/
    autocmd InsertLeave {makefile,Makefile,*.{ml,mli,c,h,ts,rs,js,html,css,py,go,sh,k,vim,hs}} match Bangy /\%100v.\|\s\+$/
    autocmd InsertEnter {makefile,Makefile,*.{ml,mli,c,h,ts,rs,js,html,css,py,go,sh,k,vim,hs}} match Bangy /\%100v./
augroup END

augroup scrypt
  " based on https://vim.fandom.com/wiki/Encryption#ccrypt
  " - added nofixeol
  " - replace ccrypt by scrypt (requires scrypt 1.3.1 or higher)
  au!
  au BufReadPre  *.scrypt setl bin viminfo= nofixeol noswapfile noundofile nobackup
  au BufReadPost *.scrypt let $PASS = inputsecret("Password: ")
  au BufReadPost *.scrypt 1,$!~/Downloads/scrypt/scrypt dec --passphrase env:PASS -
  au BufReadPost *.scrypt set nobin
  au BufWritePre *.scrypt set bin
  au BufWritePre *.scrypt silent! 1,$!~/Downloads/scrypt/scrypt enc --passphrase env:PASS -
  au BufWritePost *.scrypt silent! u
  au BufWritePost *.scrypt set nobin
augroup END
