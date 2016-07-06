call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline' " You know what is it
    Plug 'chrisbra/csv.vim' " Filetype plugin for CSV
    Plug 'scrooloose/syntastic' " Linter (syntax checker)
    Plug 'airblade/vim-gitgutter' " Shows git changes in file (A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.)
    Plug 'eugen0329/vim-esearch' " Cool file-search tool
    Plug 'tpope/vim-sensible' " 'Base' vim config
    Plug 'scrooloose/nerdtree' " File list
    Plug 'scrooloose/nerdcommenter' " Cool plugin for commenting
    Plug 'Xuyuanp/nerdtree-git-plugin' " Show git info (changes, etc) in file list
    Plug '2072/PHP-Indenting-for-VIm' " PHP indents
    Plug 'stephpy/vim-php-cs-fixer', {'do': 'wget http://get.sensiolabs.org/php-cs-fixer.phar -O ~/.config/nvim/php-cs-fixer.phar && chmod a+x ~/.config/nvim/php-cs-fixer.phar'} " PHP CS Fixer
    Plug 'cohlin/vim-colorschemes' " Dracula colortheme + airline theme, https://github.com/cohlin/vim-colorschemes
    Plug 'eshion/vim-sync' " Autoupload changed files
call plug#end()

" Keymap

"" Toggle NERDTree
map <F4> :NERDTreeToggle<CR>
imap <F4> <c-o><F4>

"" Toggle comment
map <C-_> <plug>NERDCommenterToggle
imap <C-_> <c-o><C-_>

"" Map buffers
nnoremap <silent> <C-n> :call ChangeBuf(":bn")<CR> " Next buffer on Ctrl+n
nnoremap <silent> <C-p> :call ChangeBuf(":bp")<CR> " Previous buffer on Ctrl+p
map <silent> <C-w> :call ChangeBuf(":bd")<CR> " Close current buffer on Ctrl+w
imap <C-w> <c-o><C-w>

"" File sync
nnoremap <C-u> <ESC>:call SyncUploadFile()<CR>

" Airline
let g:airline_theme = "darcula" " Theme
let g:airline#extensions#tabline#enabled = 1 " Show tabs

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " Start NERDTree on vim startup if no files specified in args
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close vim if only NERDTree buffer is opened
let NERDTreeAutoDeleteBuffer = 1 " Autoupdate buffer after file renaming
let NERDTreeShowHidden = 1 " Show hidden files
let g:NERDTreeDirArrowExpandable = '➕'
let g:NERDTreeDirArrowCollapsible = '➖'

" vim-php-cs-fixer
let g:php_cs_fixer_path = "~/.config/nvim/php-cs-fixer.phar"
let g:php_cs_fixer_level = "psr2"
let g:php_cs_fixer_enable_default_mapping = 0
autocmd BufWritePost *.php silent! :call PhpCsFixerFixFile()  | silent! :syntax on " Auto fix php file on save

" vim-sync
" autocmd BufWritePost * :call SyncUploadFile() " Auto upload file
" autocmd BufReadPre * :call SyncDownloadFile() "Auto download file


" Additional stuff

colorscheme py-darcula "Colortheme
set tabstop=4 shiftwidth=4 expandtab " Set softtabs
set number " Show line numbers

" Buffers
function! ChangeBuf(cmd)
    if (&modified && &modifiable)
        execute ":w"
    endif
    execute a:cmd
endfunction

