set nocompatible
set termguicolors
syntax on
filetype plugin indent on

set number
set ttyfast
set colorcolumn=80

set cursorline
highlight CursorLine term=bold ctermbg=150

set autoindent expandtab tabstop=2 shiftwidth=2

colorscheme gruvbox-material
set background=light

""" Key Map
map <F3> :NvimTreeToggle<CR>
map <F12> :COQnow<CR>
map <F7> :Telescope live_grep<CR>
