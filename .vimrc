set nocompatible  " be iMproved, required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'junegunn/fzf.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" Put your non-Plugin stuff after this line

" SETTINGS

" ---view---
set number
set relativenumber
"enable folding by tab spacing
set foldmethod=indent
set foldlevelstart=99
"matching parens colorscheme
hi MatchParen cterm=bold ctermbg=none ctermfg=Magenta
" visual selection color
hi Visual cterm=bold ctermbg=Black ctermfg=none
"show cursor line for current window
set cursorline
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
syntax enable
set background=light
set showcmd
":set hlsearch
"search without case match unless capitalized
set smartcase
set ignorecase
"terminal controls mouse selects
"set mouse=r
"resize windows with mouse
"set mouse=n
"cursor selects vim position
set mouse=a
:set ttymouse=xterm2
" Change Color when entering Insert Mode
autocmd InsertEnter * highlight  CursorLine ctermbg=Red ctermfg=Black
" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLine ctermbg=None ctermfg=None
let mapleader = ","

" ---Language---
" python
set ts=4 sw=4
set expandtab

" web languages
au BufNewFile,BufRead *.js, *.html, *.css
    \set tabstop=2
    \set softtabstop=2
    \set shiftwidth=2

" ---Plugin Preferences---
" NERDTREE preferences
"show NERDTREE if enter vim without file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-t> :NERDTreeToggle<CR>


" AUTO-COMPLETE preferences
" auto-complete window for YouCompleteMe disappears
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap g] :YcmCompleter GoTo<CR>
nnoremap gR :YcmCompleter GoToReferences<CR>

" VIM-MARKDOWN-PREVIEW preferences
" for vim-markdown-preview default browser and md visual with Grip
let vim_markdown_preview_github=1
let vim_markdown_preview_browser='Google Chrome'

" FZF preferences
" After install fzf with brew, enable fzf fuzzy search on vim
set rtp+=/usr/local/opt/fzf
let g:fzf_files_options =
  \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
nmap <Leader>t :Files<CR>
nmap <Leader>f :Ag<CR>
nmap <Leader>h :History<CR>
nmap <Leader>b :Buffers<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" VIM-GITGUTTER preferences
" use :GitGutterLineHighlightsToggle to highlight
nmap <Leader>g :GitGutterToggle<CR>
" update sign when saving
autocmd BufWritePost * GitGutter

"Specific to home mac
:set mouse=n
" auto-complete window for YouCompleteMe disappears
let g:ycm_autoclose_preview_window_after_completion=1
"ctrl-t open nerdtree
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2 " Always display the statusline in all windows
" for vim-markdown-preview default browser and md visual with Grip
