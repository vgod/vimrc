#!/bin/bash
# Usage: install_vim_plugin.sh

DEVUSER=devuser
DEVHOME=/home/$DEVUSER

vim +PluginInstall +qall
$DEVHOME/.vim/bundle/YouCompleteMe/install.py --clang-completer
