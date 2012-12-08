" allow ctrl+c, ctrl+v with x clipboard
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" alias w as W
" cnoreabbrev W w

noremap  <f2> :w<return>
inoremap <f2> <c-o>:w<return>

syntax enable
set showcmd
set softtabstop=4 shiftwidth=4 expandtab
set nocompatible
set autoindent
set selectmode=mouse
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*
set number
set mouse=a

" store undos
set undofile
set undodir=~/.vimundo/

" autodetect tabs/spaces
function Kees_settabs()
    if len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^\\t"')) > len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^ "'))
        set noet ts=4 sw=4
    endif
endfunction
autocmd BufReadPost * call Kees_settabs()


autocmd BufNewFile,BufRead *.go set nowrap tabstop=4 shiftwidth=4 expandtab


" solarized theme
"set background=dark
"colorscheme solarized
"set t_Co=16


" Show invisible characters
"set list 

" disable cursor keys in normal mode
map <Left>  <nop>
map <Right> <nop>
map <Up>    <nop>
map <Down>  <nop>

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


" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

