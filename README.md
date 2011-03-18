vgod's vimrc
============
Author: Tsung-Hsiang (Sean) Chang <vgod@vgod.tw>

Fork me on GITHUB  https://github.com/vgod/vimrc.

HOW TO INSTALL
--------------

1. Check out from github

        $ git clone https://github.com/vgod/vimrc ~/.vim
        $ cd ~/.vim
        $ git submodule update --init

2. Install ~/.vimrc and ~/.gvimrc

        $ ./install-vimrc.sh

3. (Optional, if you want Command-T) Compile the Command-T plugin

        $ cd .vim/bundle/command-t/ruby/command-t
        $ ruby extconf.rb
        $ make
  
UPGRADE PLUGIN BUNDLES
----------------------

If a plugin was checked out as a git submodule, you can upgrade the plugin
with git pull. For example, to upgrade Command-T 

     $ cd ~/.vim/bundle/command-t
     $ git pull

HOW TO USE
----------

see the "USEFUL SHORTCUTS" section in vimrc to learn my shortcuts.

PLUGINS
-------

* [vim-surround](https://github.com/tpope/vim-surround/blob/master/doc/surround.txt): deal with pairs of surroundings.
   

* [Command-T](https://github.com/wincent/Command-T): open and navigate between files with `cmd-t`.
  
* [snipMate](http://www.vim.org/scripts/script.php?script_id=2540): TextMate-style snippets for Vim

  `:help snipMate` to see more info.

* [YankRing](http://www.vim.org/scripts/script.php?script_id=1234): Maintains a history of previous yanks, changes and deletes 
  
  `:help yankring` to see more info.

* [VisIncr](http://www.vim.org/scripts/script.php?script_id=670): Produce increasing/decreasing columns of numbers, dates, or daynames.
  
  
* [Cute Error Marker](http://www.vim.org/scripts/script.php?script_id=2653): showing error and warning icons on line.
  
   Note: MacVim users need to enable "Use experimental renderer" to see
   graphical icons.


Language specific supports
--------------------------

* Latex: vim-latex
* Restructured Text: `ctrl-u 1~5` inserts Part/Chapter/Section headers
* CSS: `ctrl-x ctrl-o` to do omnicompletion 

Other good references
---------------------

* http://amix.dk/vim/vimrc.html
* http://spf13.com/post/perfect-vimrc-vim-config-file
