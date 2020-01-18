set laststatus=2
set statusline=%f "" For short file name

execute pathogen#infect()
""autocmd vimenter * NERDTree

colorscheme gruvbox
set background=dark
set number

" show existing tab with 4 spaces width
set tabstop=2
" " when indenting with '>', use 4 spaces width
set shiftwidth=2
" " On pressing tab, insert 4 spaces
set expandtab

let g:python_highlight_all = 1
