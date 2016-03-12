set nocompatible               " Be iMproved

"============================================================================="
"================================ PLUGINS ===================================="
"============================================================================="

" start vim-plug
call plug#begin('~/.vim/plugged')

Plug 'mbbill/undotree',                   { 'on':  'UndotreeToggle'   }
Plug 'majutsushi/tagbar',                 { 'on':  'TagbarToggle'     }
Plug 'Shougo/vimfiler.vim',               { 'on':  'VimFilerExplorer' }
Plug 'nathanaelkane/vim-indent-guides'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/unite.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'

" Stop vim-plug
call plug#end()

"============================================================================="
"================================ OPTIONS ===================================="
"============================================================================="

filetype plugin indent on                        " detects and enables filetypes

set term=$TERM                                   " set terminal to $TERM
set t_Co=256                                     " set number of colors to 256
set ttyfast                                      " fast terminal connection
augroup FastEscape                               " set timeout
  autocmd!
  au InsertEnter * set timeoutlen=100
  au InsertLeave * set timeoutlen=1000
augroup END
set background=dark                              "sets background for dark themes

syntax enable                                    " enables syntax
colorscheme modhybrid                            " set colorscheme
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set cursorline                                     " highlight current line
set mouse=a                                        " enable mouse usage
set mousehide                                      " hide the mouse cursor while typing
set enc=utf-8                                      " utf-8 by default
set nobackup                                       " turns backup off
set noswapfile                                     " turns swapfiles off
set undodir=~/.vim/undo-files/                     " undo directory
set undofile                                       " let vim creates undofiles
set ruler                                          " show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
set vb t_vb=                                       " no flash and beep
set noshowmode                                     " disables show the current mode
set showcmd                                        " show command in the statusline
set hidden                                         " buffer switching without saving
set backspace=indent,eol,start                     " backspace for dummies
set iskeyword-=.                                   " '.' is an end of word designator
set iskeyword-=#                                   " '#' is an end of word designator
set iskeyword-=-                                   " '-' is an end of word designator
set linespace=0                                    " no extra spaces between rows
set nu                                             " line numbers on
set showmatch                                      " show matching brackets/parenthesis
set shortmess=filnxtToOc                           " messages flags
set incsearch                                      " find as you type search
set hlsearch                                       " highlight search terms
set winminheight=0                                 " windows can be 0 line high
set ignorecase                                     " case insensitive search
set smartcase                                      " case sensitive when uc present
set completeopt=menuone,longest                    " complete popup rules
set completeopt-=preview                           "remove preview from complete rules
set pumheight=15                                   " limit completion popup to 15 lines
set whichwrap=b,s,h,l,<,>,[,]                      " backspace and cursor keys wrap too
set scrolljump=3                                   " lines to scroll when cursor leaves screen
set scrolloff=3                                    " min lines to keep above and below cursor
set sidescrolloff=5                                " min lines to keep from sides of cursor
set list                                           " show tabs symbol
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.     " hlight problematic whitespace
set display+=lastline                              " displays last line
set autoread                                       " autoread changes of a file
set autoindent                                     " indent as the previous line
set smarttab                                       " smart tab
set shiftwidth=4                                   " use indents of 2 spaces
set expandtab                                      " tabs are spaces, not tabs
set softtabstop=4                                  " let backspace delete indent
set nojoinspaces                                   " prevents 2 spaces after punctuation - (J)
set history=200                                    " increase limit of commands remembered
set undolevels=300                                 " remember 300 undos
set ttimeoutlen=100                                " set key codes delay to 100ms
set timeoutlen=1000                                " set keymodes delay to 1000ms
set viminfo='10,\"100,:10,%,n~/.viminfo            " restore previous session
set complete-=i                                    " remove scan from current and included files
set sessionoptions-=options                        " removed options from :mksession command
set laststatus=2                                   " always show status line
set shiftround

" Restore cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

"============================================================================="
"================================ KEYMAPS ===================================="
"============================================================================="

let mapleader = ','
nmap <silent> <leader>/ :nohlsearch<CR>
set pastetoggle=<F2>
nnoremap j gj
nnoremap k gk
inoremap <C-l> <Del>
nnoremap <Tab> <C-w><C-w>
nnoremap \ ,

" upper/lower entire word
nmap <leader>U mQviwU`Q
nmap <leader>u mQviwu`Q
" filter history in command mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>


"============================================================================="
"============================ CONFIGURE PLUGINS =============================="
"============================================================================="

" ============================== LIGHTLINE ==================================="
let g:lightline = {
      \ 'colorscheme': 'base16',
      \ 'mode_map': { 'c': 'normal'},
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], ['percent'],
      \              [ 'fileencoding', 'filetype' ] ]
      \},
      \ 'component': {
      \   'lineinfo': '%3v',
      \ },
      \ 'component_function': {
      \   'filename': 'MyFilename',
      \   'fugitive': 'MyFugitive',
      \   'mode': 'MyMode',
      \   'fileencoding': 'MyFileencoding',
      \   'filetype': 'MyFiletype',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '⎪', 'right': '⎪' }
      \}

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! MyModified()
  return &ft =~ 'help' ? 'ⓗ ' : &modified ? '*' : &modifiable ? '' : ''
endfunction

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? g:lightline.fname :
       \ fname == 'undotree_2' ? '' :
       \ fname == 'diffpanel_3' ? 'DIFF' :
       \ &ft   == 'vimfiler' ? vimfiler#get_status_string() :
       \ &ft   == 'unite' ? unite#get_status_string() :
       \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != fname ? fname : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return  fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'undotree_2' ? 'UndoTree' :
        \ fname == 'diffpanel_3' ? 'DIFF' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

let g:unite_force_overwrite_statusline    = 0
let g:vimfiler_force_overwrite_statusline = 0

"=============================== VIM-INDENT-GUIDES ==========================="
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors           = 0
let g:indent_guides_guide_size            = 1
let g:indent_guides_start_level           = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#222425   ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#292C2E   ctermbg=235

"================================== NEOCOMPLETE =============================="
let g:neocomplete#enable_at_startup              = 1
let g:neocomplete#manual_completion_start_length = 2
let g:neocomplete#auto_completion_start_length   = 3
let g:neocomplete#enable_smart_case              = 1
let g:neocomplete#enable_auto_delimiter          = 1
let g:neocomplete#max_list                       = 30
let g:neocomplete#min_pattern_length             = 3

" Define dictionaries
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <expr><C-h> pumvisible() ? neocomplete#smart_close_popup()."\<C-h>"
      \: "\<BS>"
inoremap <expr><BS> pumvisible() ? neocomplete#smart_close_popup()."\<C-h>"
      \: "\<BS>"

" Toggle Neocomplete on/off
map <F7> :NeoCompleteToggle<CR>

" Enter-key behavior
imap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"

" Tab-key behavior
imap <expr><TAB> pumvisible() ? "\<C-n>"
      \ : "\<TAB>"

"=================================== UNITE ==================================="
let g:unite_enable_ignore_case      = 1
let g:unite_enable_smart_case       = 1
let g:unite_enable_start_insert     = 0
let g:unite_winheight               = 10
let g:unite_split_rule              = 'botright'
let g:unite_prompt                  = '▸'
let g:unite_data_directory          = $HOME.'/tmp/unite'

command!  Uhelp :Unite help

nnoremap <leader><space>b :Unite -quick-match buffer<CR>
nnoremap <leader><space>f :Unite file<CR>
nnoremap <leader><space>u :Unite source<CR>

"================================= VIMFILER =================================="
let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_readonly_file_icon   = ""
nnoremap <silent> <F3> :VimFilerExplorer<CR>

"================================= UNDOTREE =================================="
let g:undotree_SetFocusWhenToggle   = 1
let g:undotree_WindowLayout         = 2
nnoremap <silent> <F4> :UndotreeToggle<CR>

"================================= TAGBAR ===================================="
let g:tagbar_autofocus              = 1
let g:tagbar_compact                = 1
let g:tagbar_iconchars              = ['▸', '▾']
nmap <silent> <F8> :TagbarToggle<CR>

let b:delimitMate_expand_space = 1

