" ~/.vimrc (configuration file for vim only)
" skeletons
function! SKEL_spec()
    0r /usr/share/vim/current/skeletons/skeleton.spec
    language time en_US
    let login = system('whoami')
    if v:shell_error
       let login = 'unknown'
    else
       let newline = stridx(login, "\n")
       if newline != -1
        let login = strpart(login, 0, newline)
       endif
    endif
    let hostname = system('hostname -f')
    if v:shell_error
        let hostname = 'localhost'
    else
        let newline = stridx(hostname, "\n")
        if newline != -1
        let hostname = strpart(hostname, 0, newline)
        endif
    endif
    exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
    exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
    exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
endfunction
autocmd BufNewFile    *.spec    call SKEL_spec()
" ~/.vimrc ends here
"-----------------------------------------------------------------------
" start Vbundle settings
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'Valloric/YouCompleteMe'

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"nnoremap A :Ag 
nnoremap F :FZF<CR>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" End of Vbundle
"-----------------------------------------------------------------------
set nu
colorscheme elflord

" latex suite settings
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
"set shellslash
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse latex-suite. Set your grep
" program to alway generate a file-name.
"set grepprg=grep\ -nH\ $*


set backup
set backupdir=~/.backup
set dir=~/.backup
syntax on
" set printers
"set pdev=color_208

" tab instead of space
set tabstop=4
set shiftwidth=4
set expandtab
set ruler
set hlsearch

"execute pathogen#infect()
set runtimepath^=~/.vim/bundle/ctrlp.vim
set list

" powerline
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
" Always show statusline
" set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

let g:clang_library_path='/opt/bats/lib'
let g:clang_user_options='|| exit 0'

" disable /enable YCM
" nnoremap ""leader>y :let g:ycm_auto_trigger=0<CR>
" nnoremap ""leader>Y :let g:ycm_auto_trigger=1<CR>
set runtimepath-=~/.vim/bundle/YouCompleteMe
" this is neede when ycm is compiled with a different version of python
"let g:ycm_server_python_interpreter='/usr/bin/python'

" switch between header and source code
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

set rtp+=~/.fzf
set runtimepath^=~/.vim/bundle/ag


" netrw (vim built-in browser)
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
"augroup END


" cscope setting
if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif
"set tags=~/db/gitlabtag

" misc
set cursorline
" set cursorcolumn

" vertical separation bar
set fillchars+=vert:│
hi VertSplit ctermbg=NONE guibg=NONE cterm=NONE
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=Black
set backspace=indent,eol,start
let &colorcolumn="80,".join(range(120,999),",")
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
