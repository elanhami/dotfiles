"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                  " Use Vim settings, rather then Vi settings

syntax enable                     " Turn on syntax highlighting

let mapleader = ","               " Leader for Vim
let &t_SI .= "\<Esc>[5 q"         " Blinking bar cursor when in insert mode
let &t_EI .= "\<Esc>[2 q"         " Solid block cursor when in normal mode

set autowriteall                  " Autosave the file always
set background=light              " Use light background of the colorscheme
set backspace=indent,eol,start    " Intuitive backspacing.
set clipboard=unnamed             " Share OS X and Vim clipboard
set colorcolumn=80                " 80 characters column
set completeopt-=preview          " Do not show omnicomplete preview window
set encoding=utf8                 " Force default encoding to UTF-8
set expandtab                     " Use spaces instead of tabs
set hlsearch                      " Highlight matches.
set ignorecase                    " Case-insensitive searching.
set incsearch                     " Highlight matches as you type.
set laststatus=2                  " Always display the status line
set list listchars=tab:»·,trail:· " Display extra whitespace
set nobackup                      " Don't make a backup before overwriting a file.
set noswapfile
set nowritebackup
set number                        " Show line numbers.
set numberwidth=5
set ofu=syntaxcomplete#Complete
set ruler                         " Show cursor position.
set showcmd                       " Display incomplete commands
set showmatch                     " Higlight matching parenthesis
set showmode                      " Display the mode you're in.
set smartcase                     " Use case-sensitive search if expression contains a capital letter.
set splitbelow                    " Split window below
set splitright                    " Split window to the right
set ttyfast                       " Faster redraw
set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS VARIABLES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeShowHidden = 1
let g:ctrlp_show_hidden = 1
let g:SuperTabDefaultCompletionType = "context"
let g:syntastic_check_on_open = 1
let g:tagbar_autoclose = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INDENTATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  autocmd User Rails.javascript* set ai nosi tabstop=4 shiftwidth=4 softtabstop=4

  " Set some variables depending on the file type
  augroup file_types
    autocmd!

    autocmd FileType markdown                        setlocal spell textwidth=80
    autocmd FileType vim,ruby,eruby,coffee           setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType html,rhtml,xml,feature,cucumber setlocal ai nosi shiftwidth=2 tabstop=2 softtabstop=2 et
    autocmd FileType javascript,scss,yaml            setlocal ai nosi shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType sass,css                        setlocal ai nosi shiftwidth=4 tabstop=4 softtabstop=4
  augroup END

  " Perform certain tasks when opening a file or creating a new file
  augroup write_operations
    autocmd!

    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

    autocmd BufRead,BufNewFile *.go     set nolist
    autocmd BufRead,BufNewFile *.jst    set filetype=html
    autocmd BufRead,BufNewFile *.ftl    set filetype=html
    autocmd BufRead,BufNewFile *.rabl   set filetype=ruby
    autocmd BufRead,BufNewFile *.md     set filetype=markdown
    autocmd BufRead,BufNewFile *.json   set filetype=javascript
    autocmd BufRead,BufNewFile *.hamlc  set filetype=haml
  augroup END
else
  set autoindent
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle NERDTree panel
map <silent> <leader>e :NERDTreeToggle<CR>
" Comment current line
map <silent> <leader>, <leader>c<space>
" Search using ag
map <leader>a :Ag<space>
" Remove highlighting on search results
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" Index ctags on the current directory
map <Leader>ct :!ctags -R .<CR><CR>
" Activate :CtrlPTag
map <Leader>t :CtrlPTag<CR>
" Toggle TagBar
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" Bubble current line down
map <S-C-Down> :m +1 <CR>
" Bubble current line up
map <S-C-Up> :m -2 <CR>
" Bubble visual block down
vnoremap <silent> <S-C-Down> :m '>+1<CR>gv=gv
" Bubble visual block up
vnoremap <silent> <S-C-Up> :m '<-2<CR>gv=gv

" Bubble current line down using h,j,k,l
map <S-C-j> :m +1 <CR>
" Bubble current line up  using h,j,k,l
map <S-C-k> :m -2 <CR>
" Bubble visual block down using h,j,k,l
vnoremap <silent> <S-C-j> :m '>+1<CR>gv=gv
" Bubble visual block up using h,j,k,l
vnoremap <silent> <S-C-k> :m '<-2<CR>gv=gv

" Move to left split window.
nnoremap <A-D-Left> <C-w>h
" Move to split window below.
nnoremap <A-D-Down> <C-w>j
" Move to split window above.
nnoremap <A-D-Up> <C-w>k
" Move to right split window.
nnoremap <A-D-Right> <C-w>l

map <leader>- :split<CR>
map <leader><bar> :vsplit<CR>

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Map commands with capital letters for simplicity
:command WQ wq
:command Wq wq
:command W w
:command Q q


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNCTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

