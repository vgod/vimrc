vgod's vimrc
============
Author: Tsung-Hsiang (Sean) Chang <vgod@vgod.tw>

Fork me on GITHUB  https://github.com/vgod/vimrc.

ONE-STEP INSTALL
----------------

Use curl (for Mac OS X):

     curl -o - https://raw.github.com/vgod/vimrc/master/auto-install.sh | sh

or wget (for most UNIX platforms):

     wget -O - https://raw.github.com/vgod/vimrc/master/auto-install.sh | sh


MANUALLY INSTALL
----------------

1. Check out from github

        git clone git://github.com/vgod/vimrc.git ~/.vim
        cd ~/.vim
        git submodule update --init

2. Install ~/.vimrc and ~/.gvimrc

        ./install-vimrc.sh

3. (Optional, if you want Command-T) Compile the Command-T plugin

        cd .vim/bundle/command-t/ruby/command-t
        ruby extconf.rb
        make

MANUALLY INSTALL ON WINDOWS
---------------------------

1. Check out from github

        cd C:\Program Files\Vim   (or your installed path to Vim)
        rmdir /s vimfiles         (This deletes your old vim configurations. If you want to keep it, use move instead of rmdir.)
        git clone git://github.com/vgod/vimrc.git vimfiles
        git submodule update --init

2. Install vimrc. Add the following line at the end of C:\Program Files\Vim\vimrc.

        source $VIM/vimfiles/vimrc


  
INSTALL & UPGRADE PLUGIN BUNDLES
--------------------------------

All plugins (except vim-latex) were checked out as git submodules, 
which can be upgraded with `git pull`. For example, to upgrade Command-T 

     cd ~/.vim/bundle/command-t
     git pull

To install a new plugin as a git submoudle, type the following commands.

     cd ~/.vim
     git submodule add [GIT-REPOSITORY-URL] bundle/[PLUGIN-NAME]

HOW TO USE
----------

see the "USEFUL SHORTCUTS" section in vimrc to learn my shortcuts.

PLUGINS
-------

* [Pathogen](http://www.vim.org/scripts/script.php?script_id=2332): Pathogen let us install a plugin as a bundle in ~/.vim/bundle seprately.

* [Nerd Tree](http://www.vim.org/scripts/script.php?script_id=1658): A tree explorer plugin for navigating the filesystem.

  Useful commands:   
    `:Bookmark [name]` - bookmark any directory as name   
    `:NERDTree [name]` - open the bookmark [name] in Nerd Tree   

* [AutoClose](http://www.vim.org/scripts/script.php?script_id=1849):  Inserts matching bracket, paren, brace or quote.

* [vim-surround](https://github.com/tpope/vim-surround/blob/master/doc/surround.txt): deal with pairs of surroundings.

* [matchit](http://www.vim.org/scripts/script.php?script_id=39): extended % matching for HTML, LaTeX, and many other languages. 

* [xmledit](http://www.vim.org/scripts/script.php?script_id=301): XML/HTML tags will be completed automatically.

* [Command-T](https://github.com/wincent/Command-T): open and navigate between files with `cmd-t`.
  
* [SuperTab](http://www.vim.org/scripts/script.php?script_id=1643): Do all your insert-mode completion with Tab.

* [snipMate](http://www.vim.org/scripts/script.php?script_id=2540): TextMate-style snippets for Vim

  `:help snipMate` to see more info.

* [YankRing](http://www.vim.org/scripts/script.php?script_id=1234): Maintains a history of previous yanks, changes and deletes 
  
  `:help yankring` to see more info.

* [VisIncr](http://www.vim.org/scripts/script.php?script_id=670): Produce increasing/decreasing columns of numbers, dates, or daynames.
  
* [Cute Error Marker](http://www.vim.org/scripts/script.php?script_id=2653): showing error and warning icons on line.
  
   MacVim users need to enable "Use experimental renderer" to see
   graphical icons.

* [vim-latex](http://vim-latex.sourceforge.net/): Latex support.

* [OmniCppComplete](http://www.vim.org/scripts/script.php?script_id=1520): C/C++ omni-completion with ctags database.

* [JavaComplete](http://www.vim.org/scripts/script.php?script_id=1785): Java Omni-completion.

* [EasyMotion](https://github.com/Lokaltog/vim-easymotion): An easy way to jump to a word.

  Useful commands:   
    `,,w` forward EasyMotion   
    `,,b` backward EasyMotion   

* [TagBar](http://majutsushi.github.com/tagbar/): browsing the tags of source files ordered by classes.

  Useful commands:    
    `F7` toggles the TagBar

Language specific supports
--------------------------

* Latex: Read `:help latex-suite.txt`
* Restructured Text: `ctrl-u 1~5` inserts Part/Chapter/Section headers
* HTML, Javascript, Python, CSS, C, C++, Java: use `TAB` to do omni-completion.
* HTML/XML: End tags are automatically completed after typing a begin tag. (Typing > twice pushes the end tag to a new line.)

Other good references
---------------------

* http://amix.dk/vim/vimrc.html
* http://spf13.com/post/perfect-vimrc-vim-config-file
