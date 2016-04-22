call plug#begin('~/.vim/plugged')
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'flazz/vim-colorschemes'
Plug 'itchyny/lightline.vim'
Plug 'tyru/caw.vim'
call plug#end()


" colorscheme
syntax on
set t_Co=256
colorscheme solarized
let g:solarized_termtrans=1
set background=dark

" lightline
set laststatus=2

" 新しい行のインデントを現在行と同じにする
set autoindent
" バックアップファイルを作るディレクトリ
set backupdir=$HOME/.vimbackup
" スワップファイル用のディレクトリ
set directory=$HOME/.vimbackup
" タブ文字、行末など不可視文字を表示する
set list
" listで表示される文字のフォーマットを指定する
set listchars=tab:>\ ,extends:<
" 行番号を表示する
set number

" caw: comment-out
nmap <C-K> <Plug>(caw:i:toggle)
vmap <C-K> <Plug>(caw:i:toggle)
