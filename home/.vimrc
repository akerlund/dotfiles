execute pathogen#infect()
""autocmd vimenter * NERDTree

" Fix contrast issues
set background=dark
if (has("termguicolors"))
  set termguicolors
endif

" The actual theme
colorscheme nord
set number

" show existing tab with 2 spaces width
set tabstop=2
" " when indenting with '>', use 2 spaces width
set shiftwidth=2
" " On pressing tab, insert 2 spaces
set expandtab
set laststatus=2
set statusline=%f "" For short file name

" Enable airline powerline fonts (requires Nerd Fonts)
let g:airline_powerline_fonts = 1

" Set the airline theme to Nord
let g:airline_theme='nord'

" Always show the status line
set laststatus=2

" Show the buffer list at the top (optional, very handy)
let g:airline#extensions#tabline#enabled = 1
