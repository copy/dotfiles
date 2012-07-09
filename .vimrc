" allow ctrl+c, ctrl+v with x clipboard
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" alias w as W
cnoreabbrev W w

noremap  <f2> :w<return>
inoremap <f2> <c-o>:w<return>

syntax enable
set showcmd
set tabstop=4 shiftwidth=4
set nocompatible
set autoindent
set selectmode=mouse
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*
set number
set mouse=a


" solarized theme
"set background=dark
"colorscheme solarized
"set t_Co=16


" Show invisible characters
"set list 

" disable cursor keys in normal mode
"map <Left>  :echo "no!"<cr>
"map <Right> :echo "no!"<cr>
"map <Up>    :echo "no!"<cr>
"map <Down>  :echo "no!"<cr>

