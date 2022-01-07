" circlelychen's vimrc
" Forked from Tsung-Hsiang (Sean) Chang <vgod@vgod.tw>

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/VundleVim/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

"Maintains a history of previous yanks, changes and deletes
Plugin 'vim-scripts/YankRing.vim'

"Produce increasing/decreasing columns of numbers, dates, or daynames.
Plugin 'vim-scripts/VisIncr'

"Vim motions to the start and end of the current indentation-delimited block
Plugin 'vim-scripts/indent-motion'

"A tree explorer plugin for navigating the filesystem
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'

"Inserts matching bracket, paren, brace or quote.
Plugin 'Raimondi/delimitMate'

"True Sublime Text style multiple selections for Vim
Plugin 'terryma/vim-multiple-cursors'

"Deal with pairs of surroundings.
Plugin 'tpope/vim-surround'

"Extended % matching for HTML, LaTeX, and many other languages.
Plugin 'vim-scripts/matchit.zip'

"XML/HTML tags will be completed automatically.
Plugin 'sukima/xmledit'

"run ack (a better grep) from vim, and shows the results in a split window.
Plugin 'mileszs/ack.vim'

"An easy way to jump to a word.
Plugin 'Lokaltog/vim-easymotion'

"Latex support.
Plugin 'vim-latex/vim-latex'

"Do all your insert-mode completion with Tab.
Plugin 'ervandew/supertab'

"browsing the tags of source files ordered by classes.
Plugin 'majutsushi/tagbar'

" Code and files fuzzy finder
Plugin 'ctrlpvim/ctrlp.vim'

" Extension to ctrlp, for fuzzy command finder
Plugin 'fisadev/vim-ctrlp-cmdpalette'

"showing error and warning icons on line.
Plugin 'Twinside/vim-cuteErrorMarker'

"expanding abbreviation like zen-coding.
Plugin 'mattn/emmet-vim'

"allows you to create better-looking, more functional vim statuslines.
Plugin 'vim-airline/vim-airline'

"shows a git diff in the 'gutter' (sign column). It shows whether each line has been added, modified, and where lines have been removed.
Plugin 'airblade/vim-gitgutter'

Plugin 'vgod/scala-vim-support'

" completion for python
Plugin 'davidhalter/vim-snipmate'
Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'scrooloose/snipmate-snippets'

Plugin 'wincent/Command-T'

" YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

" jeidi-vim
"Plugin 'davidhalter/jedi-vim'

" vim-go plugin
Plugin 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" vim-autoformat
Plugin 'Chiel92/vim-autoformat'

" cypher-vi-syntax
Plugin 'neo4j-contrib/cypher-vim-syntax'

" vim-vue
Plugin 'leafOfTree/vim-vue-plugin'

" General Settings
set shell=/bin/bash
if $TERM == "xterm"
    set t_Co=256               " 256 colors
endif
set nocompatible        " not compatible with the old-fashion vi mode
set bs=2                " allow backspacing over everything in insert mode
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set autoread            " auto read when file is changed from outside
set number              " show line number


filetype off          " necessary to make ftdetect work on Linux
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins


" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc


syntax on               " syntax highlight
set hlsearch            " search highlighting

if has("gui_running")   " GUI color and font settings
    set guifont=Osaka-Mono:h20
    set background=dark
    set t_Co=256          " 256 color mode
    set cursorline        " highlight current line
    colors moria
    highlight CursorLine          guibg=#003853 ctermbg=24  gui=none cterm=none
else
    " terminal color settings
    colors vgod
endif

set clipboard=unnamed   " yank to the system register (*) by default
set showmatch           " Cursor shows matching ) and }
set showmode            " Show current mode
set wildchar=<TAB>      " start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set autoindent          " auto indentation
set incsearch           " incremental search
set nobackup            " no *~ backup files
set copyindent          " copy the previous indentation on autoindenting
set ignorecase          " ignore case when searching
set smartcase           " ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab            " insert tabs on the start of a line according to context

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Folder setting
set foldmethod=marker


" TAB setting{
set expandtab        "replace <TAB> with spaces
set softtabstop=4
set shiftwidth=4

au FileType Makefile set noexpandtab
"}

" status line {
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \
set statusline+=\ \ \ [%{&ff}/%Y]
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
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
" set leader to
let g:mapleader=","

"replace the current word in all opened buffers
map <leader>r :call Replace()<CR>

" open the error console
map <leader>cc :botright cope<CR>
" move to next error
map <leader>] :cn<CR>
" move to the prev error
map <leader>[ :cp<CR>

" --- move around splits {
" move to and maximize the below split
map <C-J> <C-W>j<C-W>_
" move to and maximize the above split
map <C-K> <C-W>k<C-W>_
" move to and maximize the left split
nmap <c-h> <c-w>h<c-w><bar>
" move to and maximize the right split
nmap <c-l> <c-w>l<c-w><bar>
set wmw=0                     " set the min width of a window to 0 so we can maximize others
set wmh=0                     " set the min height of a window to 0 so we can maximize others
" }

" move around tabs. conflict with the original screen top/bottom
" comment them out if you want the original H/L
" go to prev tab
map <S-H> gT
" go to next tab
map <S-L> gt

" new tab
map <C-t><C-t> :tabnew<CR>
" edit tab
map <leader>te :tabedit<SPACE>
" close tab
map <C-t><C-w> :tabclose<CR>

" ,/ turn off search highlighting
nmap <leader>/ :nohl<CR>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

" ,p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" Writing Restructured Text (Sphinx Documentation) {
" Ctrl-u 1:    underline Parts w/ #'s
noremap  <C-u>1 yyPVr#yyjp
inoremap <C-u>1 <esc>yyPVr#yyjpA
" Ctrl-u 2:    underline Chapters w/ *'s
noremap  <C-u>2 yyPVr*yyjp
inoremap <C-u>2 <esc>yyPVr*yyjpA
" Ctrl-u 3:    underline Section Level 1 w/ ='s
noremap  <C-u>3 yypVr=
inoremap <C-u>3 <esc>yypVr=A
" Ctrl-u 4:    underline Section Level 2 w/ -'s
noremap  <C-u>4 yypVr-
inoremap <C-u>4 <esc>yypVr-A
" Ctrl-u 5:    unDerline Section Level 3 w/ ^'s
noremap  <C-u>5 yypVr^
inoremap <C-u>5 <esc>yypVr^A
"}

"---------------------------------------------------------------------------
" PROGRAMMING SHORTCUTS
"---------------------------------------------------------------------------

" Ctrl-[ jump out of the tag stack (undo Ctrl-])
map <C-[> <ESC>:po<CR>

" ,g generates the header guard
map <leader>g :call IncludeGuard()<CR>
fun! IncludeGuard()
    let basename = substitute(bufname(""), '.*/', '', '')
    let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
    call append(0, "#ifndef " . guard)
    call append(1, "#define " . guard)
    call append( line("$"), "#endif // for #ifndef " . guard)
endfun

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
                \ if &omnifunc == "" |
                \         setlocal omnifunc=syntaxcomplete#Complete |
                \ endif
endif

set cot-=preview "disable doc preview in omnicomplete

" make CSS omnicompletion work for SASS and SCSS
autocmd BufNewFile,BufRead *.scss             set ft=scss.css
autocmd BufNewFile,BufRead *.sass             set ft=sass.css

"---------------------------------------------------------------------------
" ENCODING SETTINGS
"---------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

fun! ViewUTF8()
    set encoding=utf-8
    set termencoding=big5
endfun

fun! UTF8()
    set encoding=utf-8
    set termencoding=big5
    set fileencoding=utf-8
    set fileencodings=ucs-bom,big5,utf-8,latin1
endfun

fun! Big5()
    set encoding=big5
    set fileencoding=big5
endfun


"---------------------------------------------------------------------------
" PLUGIN SETTINGS
"---------------------------------------------------------------------------



" ------- vim-latex - many latex shortcuts and snippets {

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash
set grepprg=grep\ -nH\ $*
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"}

" --- Command-T
let g:CommandTMaxHeight = 15

" --- SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]


" --- EasyMotion
"let g: = '<leader>m' " default is <leader>w
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

" --- TagBar
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll|jpg|png|jpeg)$',
            \ }

" --- vim-autoformat
let g:autoformat_verbosemode=1
au BufWrite *.py :Autoformat

" --- TagBar
" toggle TagBar with <F7>
nnoremap <leader>tb :TagbarToggle<CR>
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }

" --- SnipMate
let g:snipMateAllowMatchingDot = 0

" --- coffee-script
au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw! " recompile coffee scripts on write

" --- vim-gitgutter
let g:gitgutter_enabled = 1

" --- YouCompleteMe ---
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_semantic_triggers =  {
            \   'c' : ['->', '.'],
            \   'objc' : ['->', '.'],
            \   'ocaml' : ['.', '#'],
            \   'cpp,objcpp' : ['->', '.', '::'],
            \   'perl' : ['->'],
            \   'php' : ['->', '::', '"', "'", 'use ', 'namespace ', '\'],
            \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
            \   'html': ['<', '"', '</', ' '],
            \   'scss,sass,css': [ 're!^\s{4}', 're!:\s+' ],
            \   'vim' : ['re![_a-za-z]+[_\w]*\.'],
            \   'ruby' : ['.', '::'],
            \   'lua' : ['.', ':'],
            \   'erlang' : [':'],
            \   'haskell' : ['.', 're!.']
            \ }

" --- vim-go ---
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
" disable go_auto_type_info due to performance issue
"let g:go_auto_type_info = 1

" ------- vim-vue
let g:vim_vue_plugin_load_full_syntax = 1

" let Vundle manage Vundle

" ===========================================================
" FileType specific changes
" ============================================================
" Golang
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>i <Plug>(go-info)
autocmd FileType go nmap <leader>ds <Plug>(go-def-stack)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage-browser)
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" Mako/HTML
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" Python
autocmd BufNewFile,BufNewFile *.py setlocal textwidth=79 tabstop=4 fileformat=unix

" yaml
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" C/C++ specific settings
