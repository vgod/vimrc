FROM ubuntu:latest

MAINTAINER Hao-Yuan Chen <truecirclely@gmail.com>

ENV PYTHONIOENCODING UTF-8
ENV DEBIAN_FRONTEND noninteractive

ENV DEVUSER devuser
ENV PROJROOT /devprj
ENV DEVHOME /home/$DEVUSER

# Install requirements and prerequisite
RUN apt-get update
RUN apt-get install -yq python3-dev build-essential cmake git curl sudo locales silversearcher-ag

# new user as sudoers without password
# for mac user boot2docker vm "docker" user uid is 1000
# for linux user, you must change 1000 to your own uid
RUN \
  useradd -d $DEVHOME -p $(openssl passwd -crypt tsmc) -u 1000 -m -s /bin/bash $DEVUSER && \
  usermod -a -G sudo $DEVUSER && \
  chown -R $DEVUSER $DEVHOME && \
  echo "$DEVUSER ALL=NOPASSWD: ALL" >> /etc/sudoers

# Generate a /etc/profile.d so that env variables are still there when
# a new bash starts.
# Also force to switch to the WORKDIR
RUN \
  echo "#!/bin/bash" >> /etc/profile.d/profile.sh && \
  echo "sleep 1" >> /etc/profile.d/profile.sh && \
  echo "cd $PROJROOT" >> /etc/profile.d/profile.sh && \
  echo "$DEVUSER ALL=NOPASSWD: ALL" >> /etc/sudoers

# for linux user, setup bashrc
RUN \
  echo "source $DEVHOME/scripts/.git-completion.bash" >> $DEVHOME/.bashrc && \
  echo "source $DEVHOME/scripts/.git-prompt.sh" >> $DEVHOME/.bashrc && \
  echo "export GIT_PS1_SHOWDIRTYSTATE=1" >> $DEVHOME/.bashrc && \
  echo "PS1='\[\033[01m\][\[\033[01;34m\]\u@\h\[\033[00m\]\[\033[01m\] \$(__git_ps1)] \[\033[01;32m\]\w\[\033[00m\]\n\[\033[01;34m\]$\[\033[00m\]> '" >> $DEVHOME/.bashrc


RUN mkdir $PROJROOT

ADD ./docker/git-completion.bash $DEVHOME/scripts/.git-completion.bash
ADD ./docker/git-prompt.sh $DEVHOME/scripts/.git-prompt.sh
ADD ./docker/gitconfig $DEVHOME/.gitconfig
ADD ./docker/bootstrap.sh $DEVHOME/scripts/bootstrap.sh
RUN chmod 755 $DEVHOME/scripts/bootstrap.sh && \
  chmod 755 $DEVHOME/scripts/.git-completion.bash && \
  chmod 755 $DEVHOME/scripts/.git-prompt.sh && \
  chmod 755 $DEVHOME/.gitconfig

RUN ln -s $DEVHOME/scripts/bootstrap.sh /bootstrap.sh

ENTRYPOINT ["/bootstrap.sh"]
