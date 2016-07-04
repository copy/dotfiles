" allow ctrl+c, ctrl+v with x clipboard
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <C-p> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

execute pathogen#infect()

inoremap <C-space> <C-x><C-o>

let g:GPGUseAgent = 0
let g:GPGPreferSymmetric = 1

"let g:ycm_add_preview_to_completeopt=0
"let g:ycm_confirm_extra_conf=0
"set completeopt-=preview


" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowrite (file is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
    augroup END
  endif



set backspace=indent,eol,start

syntax enable
set showcmd
set softtabstop=4 shiftwidth=4 expandtab
set nocompatible
set autoindent
set smartindent
set selectmode=mouse
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*
set number
set cursorline
set mouse=a
set so=12

" always show status bar
set laststatus=2

set ignorecase smartcase

set wildmode=longest,list

set relativenumber

set encoding=utf-8
set termencoding=utf-8

set backupdir=.,/tmp

filetype indent on

set dir=~/.vimdir/

" store undos
set undofile
set undodir=~/.vimundo/
set undolevels=1000

set cmdheight=2

set hls
set wildmenu

autocmd BufNewFile,BufRead *.go set nowrap tabstop=4 shiftwidth=4 expandtab

set fileformats+=dos

" solarized theme
set background=dark
colorscheme solarized

"set background=light

if has('gui_running')
  set guifont=Monospace\ 13
=
endif

" Show invisible characters
"set list

" disable cursor keys in normal mode
map <Left>  <nop>
map <Right> <nop>
map <Up>    <nop>
map <Down>  <nop>

imap <Left>  <nop>
imap <Right> <nop>
imap <Up>    <nop>
imap <Down>  <nop>

" make vim load latex suite
filetype plugin on

" don't fold sections
let Tex_FoldedSections=""
let Tex_FoldedEnvironments=""
let Tex_FoldedMisc=""


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


" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" reload file
map <F5> <Esc>:edit<Return>
map <F6> <Esc>:edit<Return>


"let g:syntastic_javascript_checker = "closurecompiler"
"let g:syntastic_javascript_closure_compiler_path = '~/closure-compiler.jar'
" It takes additional options for Google Closure Compiler with the variable
" g:syntastic_javascript_closure_compiler_options.
"let g:syntastic_javascript_checker = "jslint"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 3
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"let g:syntastic_disabled_filetypes=['ocaml']
"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
"let g:syntastic_check_on_open = 0
"let g:syntastic_ignore_files = ['.ml$']

let g:syntastic_reuse_loc_lists = 0

"let g:syntastic_ocaml_use_ocamlc = 1
"let g:syntastic_ocaml_use_ocamlbuild = 1

let g:syntastic_ocaml_checkers=['merlin']

"filetype indent on
"filetype plugin on
au BufRead,BufNewFile *.ml,*.mli compiler ocaml


let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

"Also run the following line in vim to index the documentation:
":execute "helptags " . g:opamshare . "/merlin/vim/doc"

autocmd FileType ocaml execute ":source " . g:opamshare . "/ocp-indent/vim/indent/ocaml.vim"


"let g:merlin_display_occurrence_list = 0
nmap <LocalLeader>*  <Plug>(MerlinSearchOccurrencesForward)

autocmd FileType ocaml map <F5> :make<enter>
autocmd FileType ocaml set softtabstop=2 shiftwidth=2

"autocmd FileType ocaml noremap <f4> :MerlinILocate<cr>
autocmd FileType ocaml noremap <f4> :MerlinDocument<cr>
autocmd FileType ocaml noremap <f3> :MerlinLocate<cr>
autocmd FileType ocaml noremap <f2> :MerlinTypeOf<cr>
autocmd FileType ocaml vnoremap <f2> :'<,'>:MerlinTypeOfSel<cr>gv
autocmd FileType ocaml noremap <f6> :MerlinOccurrences<cr>
autocmd FileType ocaml noremap <f7> :MerlinToggleTypeHistory<cr><c-w>w

map <F6> :SyntasticToggleMode<enter>

autocmd FileType rust map <F5> :make<enter>
"let g:syntastic_quiet_messages = {'level': 'warnings'}


autocmd FileType python map <F5> :!./%<enter>
autocmd FileType python map <F4> :! ipython -i %<enter>

autocmd FileType cpp let g:loaded_youcompleteme = 1
autocmd FileType h let g:loaded_youcompleteme = 1
"autocmd FileType c
autocmd FileType cpp noremap <f2> :FSHere<cr>
autocmd FileType cpp noremap <f3> :make<cr>
autocmd FileType cpp noremap <f4> :SyntasticCheck<cr>

let g:syntastic_cpp_checkers=['']

"autocmd FileType javascript :SyntasticToggleMode

"let g:syntastic_python_python_exec = '/usr/bin/python2'
"let g:syntastic_disabled_filetypes=['js']

"au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
"au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
"au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>

"au FileType haskell nnoremap <buffer> <F1> :GhcModType<CR>

let g:ycm_semantic_triggers = {'haskell' : ['.']}

au BufNewFile,BufRead *.ejs set filetype=javascript

"let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E225'
"let g:syntastic_python_checkers=['pep8', 'pylint', 'python']
let g:syntastic_python_checkers=['pylint', 'python']
"let g:syntastic_debug = 1


"let g:syntastic_java_javac_classpath = "<path>/PCA_Framework/lib/*.jar"
"let g:syntastic_java_javac_classpath = g:syntastic_java_javac_classpath . ":<path>/PCA_Framework/src/"

" remove ex mode
map Q <Nop>

augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd -g 1
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd -g 1
  au BufWritePost *.bin set nomod | endif
augroup END


