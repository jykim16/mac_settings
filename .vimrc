"install latest vim with `brew install vim --with-override-system-vi`
set nocompatible  " be iMproved, required

"---Vundle Plugins---
    " sources
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin() "can add path to bundle as arg
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
    " vundle commands
        " :PluginList       - lists configured plugins
        " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
        " :PluginSearch foo - searches for foo; append `!` to refresh local cache
        " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" ---Language---
    " default
        "expands tab to spaces
        set expandtab
        set tabstop=4
        set softtabstop=4
        set shiftwidth=4

    " python
        "this is default
        "autocmd FileType python
        "\ set tabstop=4 |
        "\ set softtabstop=4 |
        "\ set shiftwidth=4
        " run python interpreter on selected lines
        xnoremap <leader>p :w !python<cr>
        " highlight the 80th column of wide lines...
        highlight ColorColumn ctermbg=magenta
        call matchadd('ColorColumn', '\%80v', 100)

    " web languages
        autocmd BufNewFile,BufRead *.js,*.jsx,*.html,*.css
        \ set tabstop=2 |
        \ set softtabstop=2 |
        \ set shiftwidth=2

" ---View---
    " visual
        set number
        set relativenumber
        "enable folding by tab spacing
        set foldmethod=indent
        set foldlevelstart=99
        " neat fold
        function! NeatFoldText()
            let indent_level = indent(v:foldstart)
            let indent = repeat(' ', indent_level)
            let line = ' ' . getline(v:foldstart)[indent_level:] . ' '
            let lines_count = v:foldend - v:foldstart + 1
            let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
            let foldchar = matchstr(&fillchars, 'fold:\zs.')
            let foldtextstart = strpart('+' . repeat(foldchar, 2) . line, 0, (winwidth(0)*2)/3)
            let foldtextend = lines_count_text . repeat(foldchar, 8)
            let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn + indent_level
            return indent . foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
        endfunction
        set foldtext=NeatFoldText()
        "matching parens colorscheme
        hi MatchParen cterm=bold ctermbg=none ctermfg=Magenta
        " visual selection color
        hi Visual cterm=bold ctermbg=Black ctermfg=none
        " enables syntax highlighting
        syntax enable
        " shows command you are using in bottom right
        set showcmd
        " use of normal ANSI Colors (in term preferences)
        set background=light
        " use of bright ANSI Colors
        "set background=dark
    " cursor and mouse
        " allows backspace over anything in insert mode
        set backspace=2
        "show cursor line for current window
        set cursorline
        augroup CursorLine
          au!
          au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
          au WinLeave * setlocal nocursorline
        augroup END
        "terminal controls mouse selects
        "set mouse=r
        "resize windows with mouse
        "set mouse=n
        "cursor selects vim position
        set mouse=a
        :set ttymouse=xterm2
        " Change Color when entering Insert Mode
        autocmd InsertEnter * highlight  CursorLine ctermbg=Blue ctermfg=Black
        " Revert Color to default when leaving Insert Mode
        autocmd InsertLeave * highlight  CursorLine ctermbg=None ctermfg=None
    " search and highlight
        " highlight all search items
        ":set hlsearch
        " search without case match unless capitalized
        set smartcase
        set ignorecase
        " adjust folding color
        hi Folded ctermbg=None ctermfg=white
        "finds all trailing whitespace and highlights
        highlight ExtraWhitespace ctermbg=darkgreen
        match ExtraWhitespace /\s\+$/

" ---Keymappings---
        let mapleader = ","
        " move current line up one line
        nnoremap <C-j> :m .+1<CR>==
        " move current line down one line
        nnoremap <C-k> :m .-2<CR>==
        " if +clipboard then copy to mac clipboard in visual selection
        vmap <C-y> "*y
        " if +clipboard then copy current word to mac clipboard
        nnoremap <C-y> "*yiw
        " if +clipboard then paste from mac clipboard from normal mode
        nnoremap <C-p> "*p

" ---Plugin Preferences---
    " NERDTREE preferences
        "show NERDTREE if enter vim without file
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
        " use :NERDTreeToggle if don't want to go to current file
        map <C-t> :NERDTreeFind <CR>

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
        " Ag only searches file contents, not file names
        command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

    " VIM-GITGUTTER preferences
        " use :GitGutterLineHighlightsToggle to highlight
        nmap <Leader>g :GitGutterToggle<CR>
        " update sign when saving
        autocmd BufWritePost * GitGutter

    " VIM-FUGITIVE preferences
        " when using diffing, use vsplit as default
        set diffopt+=vertical
        " https://blog.afoolishmanifesto.com/posts/iterating-over-chunks-of-a-diff-in-vim/
        command Gdiffs cexpr system('git diff \| diff-hunk-list')

    " VIM-AIRLINE preferences
        " inactive windows do not collapse
        let g:airline_inactive_collapse = 0
        " git hunk diff counts showing disabled or non-zero
        "let g:airline#extensions#hunks#enabled = 0
        let g:airline#extensions#hunks#non_zero_only = 1
        function! AirLineLight()
            "let g:airline_section_z = airline#section#create_right([''])
            let g:airline_section_z = airline#section#create_right(['%l:%c'])
            "let g:airline_section_b = airline#section#create(['branch'])
        endfunction
        autocmd Vimenter * call AirLineLight()
        let g:airline#extensions#default#section_truncate_width = {
          \ 'a': 60,
          \ 'b': 50,
          \ 'x': 90,
          \ 'y': 90,
          \ 'z': 90
          \ }

"Specific to home mac
:set mouse=n
" auto-complete window for YouCompleteMe disappears
let g:ycm_autoclose_preview_window_after_completion=1
