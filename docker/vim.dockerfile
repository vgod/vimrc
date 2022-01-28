FROM circlelychen/dev:base

ENV DEVUSER devuser
ENV DEVHOME /home/$DEVUSER
ENV GOROOT /usr/local/go
ENV GOPATH $DEVHOME/go
ENV PATH $DEVHOME/go/bin:/usr/local/go/bin:$PATH

## install VIM with plugins
RUN mkdir -p $DEVHOME/.vim
ADD ./colors $DEVHOME/.vim/colors
ADD ./indent $DEVHOME/.vim/indent
ADD ./install-vimrc.sh $DEVHOME/.vim/install-vimrc.sh
ADD ./vimrc $DEVHOME/.vim/vimrc
ADD ./gvimrc $DEVHOME/.vim/gvimrc
RUN chown -R $DEVUSER:$DEVUSER $DEVHOME/

USER devuser
RUN cd $DEVHOME/.vim && \
    ./install-vimrc.sh && \
    git clone https://github.com/VundleVim/vundle.vim $DEVHOME/.vim/bundle/vundle
RUN vim +PluginInstall +qall
RUN vim +GoInstallBinaries +qa
RUN $DEVHOME/.vim/bundle/YouCompleteMe/install.py --clang-completer
RUN $DEVHOME/.vim/bundle/YouCompleteMe/install.py --cs-completer
RUN $DEVHOME/.vim/bundle/YouCompleteMe/install.py --go-completer

USER root
RUN rm -rf /var/lib/apt/lists/*


