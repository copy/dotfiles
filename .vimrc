" TODO: Avoid global mappings, set per filetype

execute pathogen#infect()

" allow ctrl+c, ctrl+v with x clipboard
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <C-p> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p


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


let g:python_host_prog = "/usr/bin/python2.7"
let g:python3_host_prog = "/usr/bin/python3"


if !has('nvim')
    " required for ocaml-vim to handle jumping between let/in etc.
    packadd! matchit
endif

map <silent> <cr> :noh<cr><c-cr>

" https://github.com/Shougo/deoplete.nvim/issues/492#issuecomment-306751415
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

if exists("vimpager")
    " less.vim is annoying since it can't select text
    let g:less = { 'enabled': 0 }
    " emulate the useful less.vim features
    noremap <buffer> d <C-d>
    noremap <buffer> u <C-u>
    noremap <buffer> q :q<cr>
    " Prevent delay when pressing d https://github.com/rkitover/vimpager/issues/131
    let g:loaded_surround = 1
endif

autocmd FileType ocaml let g:completor_disable_filename = 1

"call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
"\ 'name': 'omni',
"\ 'whitelist': ['*'],
"\ 'completor': function('asyncomplete#sources#omni#completor')
"\  }))

let g:completor_python_omni_trigger = '.*'
let g:completor_ocaml_omni_trigger = '.*'
"let g:completor_ocaml_omni_trigger = '([\w-]+|@[\w-]*|[\w-]+:\s*[\w-]*)$'
"let g:completor_javascript_omni_trigger = '.*'
let g:completor_min_chars = 1
let g:completor_completion_delay = 90

let g:completor_disable_buffer = ['ocaml', 'javascript']

"let g:completor_js_omni_trigger = '.*'
let g:completor_node_binary = '/usr/bin/node'


" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#enable_refresh_always = 1

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'
"let g:neocomplete#sources#omni#input_patterns.ocaml = '.*'

if !exists('g:neocomplete#delimiter_patterns')
    let g:neocomplete#delimiter_patterns= {}
endif
let g:neocomplete#delimiter_patterns.ocaml = ['#', '##', '.']

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
"let g:neocomplete#keyword_patterns.ocaml = '[''`#.]\?\h[[:alnum:]_'']*'


let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
"let g:deoplete#omni#input_patterns.ocaml = '[^. *\t]\.\w*|\s\w*|#'
"let g:deoplete#omni#input_patterns.ocaml = '.*'

let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_smart_case = 0
let g:deoplete#max_menu_width = 62
let g:deoplete#max_abbr_width = 60
let g:deoplete#max_list = 0

let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources.ocaml = ['buffer', 'around']

"let g:SuperTabDefaultCompletionType = "context"
""let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
""let g:SuperTabContextTextOmniPrecedence = ['&completefunc', '&omnifunc']
"let g:SuperTabContextTextOmniPrecedence = ['&omnifunc']
"autocmd FileType ocaml let b:SuperTabCompletionContexts = ['ClojureContext', 's:ContextText']
"    function! ClojureContext()
"      let curline = getline('.')
"      let cnum = col('.')
"      let synname = synIDattr(synID(line('.'), cnum - 1, 1), 'name')
"      if curline =~ '<\@<!/\.\?\w*\%' . cnum . 'c'
"          return "\<c-x>\<c-f>"
"      elseif synname !~ '\(String\|Comment\)'
"          return "\<c-x>\<c-o>"
"      endif
"    endfunction
"    "let g:SuperTabRetainCompletionDuration = "session"
"autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

"let g:jedi#show_call_signatures = 2

" Super-tab is cool and nicely document, but doesn't provide auto-open
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"


" show highlighting name for debugging highlight scripts
map <c-a-p> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

let g:GPGUseAgent = 0
let g:GPGPreferSymmetric = 1

set backspace=indent,eol,start

syntax enable
set showcmd
set softtabstop=4 shiftwidth=4 expandtab
set nocompatible
set autoindent
" disabled, doesn't indent '#' in Python properly
"set smartindent
set selectmode=mouse
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set number
set relativenumber
set cursorline
set mouse=a
set scrolloff=12
set nohidden " unload buffer when closing all tabs/splits with this buffer
"set synmaxcol=100
"set maxmempattern=100000
" jump to search results while typing search
set incsearch
" always show status bar
set laststatus=2
set ignorecase smartcase
set autoread

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

set cc=100
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

set hls
set wildmenu

" solarized theme
set background=dark
colorscheme solarized

if has('gui_running')
  set guifont=Monospace\ 13
endif

" Show invisible characters
"set list

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

" don't fold sections
let Tex_FoldedSections=""
let Tex_FoldedEnvironments=""
let Tex_FoldedMisc=""
let g:vim_markdown_folding_disabled = 1
set foldmethod=manual
set nofoldenable

" grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"


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


function! RestoreCursor()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction
augroup resCur
    autocmd!
    autocmd BufWinEnter * call RestoreCursor()
augroup END


"command PrettyJSON :%!python -m json.tool
command PrettyJSON :call JsonBeautify()
command PrettyJavaScript :call JsBeautify()

" reload file
map <F5> <Esc>:edit<Return>


augroup autoAleLint
    autocmd!
    autocmd TextChanged,InsertLeave,FocusLost * silent! ALELint
augroup END
"let g:ale_open_list = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_lint_on_text_changed = 'never'
let g:ale_javascript_jshint_executable = "jshint-default"
let g:ale_c_clang_options = '-Wno-bitwise-op-parentheses -Wno-gnu-binary-literal'
let g:ale_python_mypy_options = '--ignore-missing-imports --allow-untyped-defs --cache-dir /home/fabian/.cache/mypy'
let g:ale_linters = {
\   'c': ['clang'],
\   'python': ['mypy'],
\}


" TODO: Only execute for OCaml files (merlin breaks when this is moved below)
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
if !empty(glob(getcwd() . "/bsconfig.json")) || !empty(glob(expand('%:p:h') . "/bsconfig.json"))
    execute "set rtp+=/home/fabian/.opam/4.02.3+buckle-master/share/merlin/vim/"
    autocmd BufReadPost * let b:merlin_path = "/home/fabian/.opam/4.02.3+buckle-master/bin/ocamlmerlin"
else
    execute "set rtp+=" . g:opamshare . "/merlin/vim"
end
execute "set rtp^=" . g:opamshare . "/ocp-indent/vim"


augroup setup_ocaml
    autocmd!
    autocmd Filetype ocaml call SetOcamlOptions()
augroup END
function SetOcamlOptions()

    highlight link ALEError Error
    highlight link ALEWarning Error

    let g:merlin_ignore_warnings = 'true'

    "Also run the following line in vim to index the documentation:
    ":execute "helptags " . g:opamshare . "/merlin/vim/doc"

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

    " TODO: Make use of nvim's terminal for tests and compilation
endfunction


augroup vimrc
    autocmd!

    autocmd BufNewFile,BufRead *.go set nowrap tabstop=4 shiftwidth=4 expandtab
    "autocmd BufNewFile,BufRead jbuild set ft=lisp

    " Maps Coquille commands to <F2> (Undo), <F3> (Next), <F4> (ToCursor)
    autocmd FileType coq call coquille#FNMapping()
    autocmd FileType coq setlocal iskeyword+='

    " Close scratch window automatically
    autocmd CompleteDone * pclose

    autocmd BufRead,BufNewFile *.ml,*.mli compiler ocaml

    autocmd FileType rust map <F5> :make<enter>

    autocmd FileType python map <F5> :!./%<enter>
    "autocmd FileType python map <F4> :! ipython -i %<enter>
    autocmd FileType python map <f2> <s-k>
    autocmd FileType python map <f3> <leader>g
    autocmd FileType python map <f4> <leader>n

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

" tabs setup
map <c-j> :tabp<cr>
map <c-k> :tabn<cr>
imap <c-j> <ESC><c-j>
imap <c-k> <ESC><c-k>
imap <c-t> <ESC><c-t>
if has('nvim')
    tmap <c-j> <ESC><c-j>
    tmap <c-k> <ESC><c-k>
    tmap <c-t> <ESC><c-t>
endif

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
  \ 'ctrl-t': 'tab split',
  \ 'enter': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

nmap <c-t> :FZF<cr>

" open file/url under cursor in new tab
nnoremap gf <C-W>gf
vnoremap gf <C-W>gf

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
        autocmd TermOpen * setlocal number relativenumber
        autocmd BufEnter term://* startinsert
        autocmd TermOpen term://* startinsert
        autocmd TermOpen term://* call UndoEscMappingFzf()
    augroup END
    command TT :tabe | :term
    command Test :tabe | :term jbuilder runtest
endif

"autocmd BufNewFile,BufRead /home/fabian/some-folder/* set cc=99
"autocmd BufNewFile,BufRead /home/fabian/some-folder/* let g:syntastic_python_python_exec = g:python_host_prog

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
