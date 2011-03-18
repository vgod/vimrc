" vgod's vimrc
" https://github.com/vgod/vimrc
"
" see the "USEFUL SHORTCUTS" section to learn my shortcuts
"
" Other good references:
" http://amix.dk/vim/vimrc.html
" http://spf13.com/post/perfect-vimrc-vim-config-file

" For pathogen.vim: auto load all plugins in .vim/bundle
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" General Settings

set nocompatible	" not compatible with the old-fashion vi mode
set bs=2		" allow backspacing over everything in insert mode
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set autoread		" auto read when file is changed from outside


filetype plugin on

" many plugins use hotkeys that starts with <leader>
let mapleader=","

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc


if &t_Co > 2
  syntax on		" syntax highlight
  set hlsearch		" search highlighting
endif

if has("gui_running")	" GUI color and font settings
  set guifont=Monaco:h16
  set background=dark 
  colors moria
else
" terminal color settings
  colors vgod
endif

set clipboard=unnamed	" yank to the system register (*) by default
set showmatch		" Cursor shows matching ) and }
set showmode		" Show current mode
set wildchar=<TAB>	" start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set autoindent		" auto indentation
set incsearch		" incremental search
set nobackup		" no *~ backup files
set copyindent		" copy the previous indentation on autoindenting
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to context


" TAB setting{
   set expandtab        "replace <TAB> with spaces
   set softtabstop=3 
   set shiftwidth=3 

   au FileType Makefile set noexpandtab
"}      							

" status line {
set laststatus=2
set statusline=\ %{HasPaste()}%<%-25.40(%F%)%m%r%h\ %w\ \ 
set statusline+=\ \ \ [%{&ff}/%Y] 
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\ 
set statusline+=%=%-14.(%l,%c%V%)\ %p%%/%L

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/vgod', "~", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

"}


"----------------------------------------------------------------------
"some useful commands and plugins
"----------------------------------------------------------------------


"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"--------------------------------------------------------------------------- 
" Tip #382: Search for <cword> and replace with input() in all open buffers 
"--------------------------------------------------------------------------- 
fun! Replace() 
    let s:word = input("Replace " . expand('<cword>') . " with:") 
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge' 
    :unlet! s:word 
endfun 


"--------------------------------------------------------------------------- 
" USEFUL SHORTCUTS
"--------------------------------------------------------------------------- 
map <leader>r :call Replace()<CR>   "replace the current word in all opened buffers

map <leader>] <ESC>:cn<CR>    " move to next error
map <leader>[ <ESC>:cp<CR>    " move to the prev error

" move around splits
map <C-J> <C-W>j<C-W>_        " move to and maximize the below split 
map <C-K> <C-W>k<C-W>_        " move to and maximize the above split 
nmap <c-h> <c-w>h<c-w><bar>   " move to and maximize the left split 
nmap <c-l> <c-w>l<c-w><bar>   " move to and maximize the right split  
set wmw=0                     " set the min width of a window to 0 so we can maximize others 
set wmh=0                     " set the min height of a window to 0 so we can maximize others

" move around tabs. conflict with the original screen top/bottom
" comment them out if you want the original H/L
map <S-H> gT                  " go to prev tab 
map <S-L> gt                  " go to next tab

" ,/ turn off search highlighting
nmap <leader>/ :nohl<CR>      


" ,p toggles paste mode {
nmap <leader>p :call TogglePaste()<CR>
function! TogglePaste()
    if &paste
      set nopaste
    else
      set paste
    endif
endfunction
"}
