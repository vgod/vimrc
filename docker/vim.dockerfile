FROM circlelychen/dev:base

ENV DEVUSER devuser
ENV DEVHOME /home/$DEVUSER

RUN apt-get install -yq vim && \
    rm -rf /var/lib/apt/lists/*

## install VIM plugins
RUN git clone https://github.com/circlelychen/vimrc.git $DEVHOME/.vim && \
    cd $DEVHOME/.vim && \
    ./install-vimrc.sh
RUN git clone https://github.com/VundleVim/vundle.vim $DEVHOME/.vim/bundle/vundle

ADD ./docker/install_vim_plugin.sh $DEVHOME/scripts/install_vim_plugin.sh
RUN chmod 755 $DEVHOME/scripts/install_vim_plugin.sh

RUN chown -R $DEVUSER $DEVHOME/.vim
