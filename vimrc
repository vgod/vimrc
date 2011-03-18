" vgod's vimrc
" https://github.com/vgod/vimrc

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
  colo vgod
endif

