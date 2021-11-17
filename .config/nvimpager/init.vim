" this shadows my j/k mappings for pager-like behaviour
let g:no_man_maps = 1

noremap <buffer> d <C-d>
noremap <buffer> u <C-u>
noremap <buffer> q :q<cr>

set runtimepath+=~/.config/nvim/start/vim-solarized8
set runtimepath+=~/.config/nvim/start/vim-highlightedyank

set clipboard=unnamedplus
set ignorecase smartcase

set background=dark
set termguicolors
colorscheme solarized8_flat

map Q <Nop>

" git diff not handled by vim-solarized8
hi def link diffAdded DiffAdd
hi def link diffRemoved DiffDelete

" show highlighting name for debugging highlight scripts
map <c-a-p> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" https://github.com/Shougo/deoplete.nvim/issues/492#issuecomment-306751415
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
nnoremap <expr> n (v:searchforward ? 'n' : 'N')
nnoremap <expr> N (v:searchforward ? 'N' : 'n')

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

augroup nvimpagerfix
    autocmd!
    " override some nvimpager mappings:
    " - move both cursor and screen using j/k (useful for copying text)
    " - disable g, singe it has a delay due to two-character commands
    autocmd VimEnter * nnoremap k <C-y>k
    autocmd VimEnter * nnoremap j <C-e>j
    autocmd VimEnter * silent! unmap g
augroup END

nnoremap <C-j> j
nnoremap <C-k> k

function! SetHighlight()
    if &filetype ==# 'git' || &filetype ==# 'diff'
        syn match diffAdded "{+.\{-}+}"
        syn match diffRemoved "\[-.\{-}-\]"
    endif
endfunction

augroup gitdiffhl
    autocmd VimEnter * call SetHighlight()
augroup END
