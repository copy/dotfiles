" allow ctrl+c, ctrl+v with x clipboard
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <C-p> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" alias w as W
" cnoreabbrev W w
execute pathogen#infect()

noremap  <f2> :w<return>
inoremap <f2> <c-o>:w<return>

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
set so=15

set encoding=utf-8
set termencoding=utf-8

filetype indent on

" store undos
set undofile
set undodir=~/.vimundo/
set undolevels=1000


au BufNewFile,BufRead *.js.macro set filetype=javascript

set hls

" autodetect tabs/spaces
function Kees_settabs()
    if len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^\\t"')) > len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^ "'))
        set noet ts=4 sw=4
    endif
endfunction
autocmd BufReadPost * call Kees_settabs()


autocmd BufNewFile,BufRead *.go set nowrap tabstop=4 shiftwidth=4 expandtab


"let g:solarized_termcolors=256
"solarized theme
set background=dark
colorscheme solarized
"set t_Co=16

"set background=light

"color grb256
"color github
"color solarized



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



" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

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


map <F5> <Esc>:edit<Return>


"noremap n n:call HighlightNearCursor()<CR>
"noremap p p:call HighlightNearCursor()<CR>
"noremap * *:call HighlightNearCursor()<CR>

"nnoremap <C-K> :call HighlightNearCursor()<CR>

function HighlightNearCursor()
  if !exists("s:highlightcursor")
    match Todo /\k*\%#\k*/
    let s:highlightcursor=1
  else
    match None
    unlet s:highlightcursor
  endif
endfunction


"execute pathogen#infect()
"let g:syntastic_javascript_checker = "closurecompiler"
"let g:syntastic_javascript_closure_compiler_path = '~/closure-compiler.jar'
" It takes additional options for Google Closure Compiler with the variable
" g:syntastic_javascript_closure_compiler_options.

"let g:syntastic_javascript_checker = "jslint"

set fileformats+=dos



" Transparent editing of gpg encrypted files.
augroup encrypted
au!
" First make sure nothing is written to ~/.viminfo while editing
" an encrypted file.
autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
" We don't want a swap file, as it writes unencrypted data to disk
autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
" Switch to binary mode to read the encrypted file
autocmd BufReadPre,FileReadPre      *.gpg set bin
autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
autocmd BufReadPre,FileReadPre      *.gpg let shsave=&sh
autocmd BufReadPre,FileReadPre      *.gpg let &sh='sh'
autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
autocmd BufReadPost,FileReadPost    *.gpg let &sh=shsave
" Switch to normal mode for editing
autocmd BufReadPost,FileReadPost    *.gpg set nobin
autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
" Convert all text to encrypted text before writing
autocmd BufWritePre,FileWritePre    *.gpg set bin
autocmd BufWritePre,FileWritePre    *.gpg let shsave=&sh
autocmd BufWritePre,FileWritePre    *.gpg let &sh='sh'
"autocmd BufWritePre,FileWritePre    *.gpg '[,']!gpg --encrypt --default-recipient-self 2>/dev/null
autocmd BufWritePre,FileWritePre    *.gpg '[,']!gpg --symmetric 2>/dev/null
autocmd BufWritePre,FileWritePre    *.gpg let &sh=shsave
" Undo the encryption so we are back in the normal text, directly
" after the file has been written.
autocmd BufWritePost,FileWritePost  *.gpg silent u
autocmd BufWritePost,FileWritePost  *.gpg set nobin
augroup END
