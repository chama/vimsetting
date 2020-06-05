" Basic Python-friendly Vim configuration. Colorscheme is changed from
" 'default' to make screenshots look better in print.
" Leaderキーをspaceに変更 \ => <space>
let mapleader = "\<space>"

syntax on                  " Enable syntax highlighting.
filetype plugin indent on  " Enable file type based indentation.
set tags=tags              " 親ディレクトリのtagsファイルを再帰的に探す
set ignorecase             " 大文字小文字を区別せずに検索

set autoindent             " Respect indentation when starting a new line.
set expandtab              " Expand tabs to spaces. Essential in Python.
set tabstop=4              " Number of spaces tab is counted for.
set shiftwidth=4           " Number of spaces to use for autoindent.

set backspace=2            " Fix backspace behavior on most terminals.

set foldmethod=indent      " インデントベースで折りたたみを行う

set hlsearch               " / or ?での検索時にすべてのマッチをハイライトする

set wildmenu               " Tabによる自動補完を有効にする
set wildmode=list:longest,full      " 最長マッチまで補完してから自動補完メニューを開く
set number                 " 行番号の表示
set relativenumber         " 相対行番号の表示

set background=dark
colorscheme molokai         " Change a colorscheme.
set directory=$HOME/.vim/swap//
set undofile " すべてのファイルについて永続undoを有効にする
if !isdirectory(expand("$HOME/.vim/undodir"))
    call mkdir(expand("$HOME/.vim/undodir"),"p")
endif
set undodir=$HOME/.vim/undodir
" packloadall " すべてのプラグインをロードする
" silent! helptags ALL " すべてのプラグイン用にヘルプファイルをロードする
call plug#begin() " Manage plugins with vim-plug.
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'mattn/emmet-vim' "htmlでemmetを利用する。入力後は<C-y>,でemmet
Plug 'tpope/vim-surround' "[]や''などの操作
Plug 'tpope/vim-commentary' "visualで選択後gccでコメントアウト
Plug 'vim-airline/vim-airline' "vimのステータスバーのカスタマイズ
Plug 'sheerun/vim-polyglot' "各種言語のシンタックス


let g:plug_timeout = 300 "YouCompleteMeはコンパイルに時間がかかるためタイムアウトを伸ばす
Plug 'ycm-core/YouCompleteMe', {'do': './install.py'}

call plug#end()

noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

" noremap <leader>] :YcmCompleter GoTo<cr>

inoremap ' ''<esc>i
inoremap " ""<esc>i
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i
inoremap < <><esc>i

autocmd VimEnter * NERDTree " Vim起動時にNERDTreeを開く

" NERDTreeのウィンドウしか開かれていないときは自動的に閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
            \ b:NERDTree.isTabTree()) | q | endif

noremap <leader>n :NERDTreeToggle<cr>

" autocmd BufWritePost *.py silent! !ctags -R & " Pythonのファイルを保存するたびにタグファイルを再生成する bugによりunexpected end of fileのerrorが出るぽ
