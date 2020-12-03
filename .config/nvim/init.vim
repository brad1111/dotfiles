call plug#begin(stdpath('data') . '/plugged')
Plug 'tpope/vim-sensible'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'tomasiser/vim-code-dark'
call plug#end()
set tabstop=2 shiftwidth=4 expandtab
set statusline^=%{coc#status()}
