#!/usr/bin/env bash
#
# Usage: buildme.sh [TAG]
# - TAG: a string composed of REPO:IMG

IMG="circlelychen/dev"

# build base and vim containers
docker build --force-rm -t $IMG:base -f docker/base.dockerfile .
docker build --force-rm -t $IMG:vim -f docker/vim.dockerfile .

# build vim-plugin containers
TMPNAME=vim-plugin-$(date +"%m-%d-%H-%M")
TAG=myvim
cmd="docker run --name $TMPNAME -it \
    -e "USERID=$(id -u)" \
    -e "GROUPID=$(id -u)" \
    -v $(pwd):/devprj \
    $IMG:vim /home/devuser/scripts/install_vim_plugin.sh"
echo $cmd
eval $cmd

cmd="docker commit \
    --change='CMD [ ]' \
    --message 'Install VIM plugins and YCM' $TMPNAME $IMG:$TAG"
echo $cmd
eval $cmd

cmd="sleep 5"
echo $cmd
eval $cmd

cmd="docker rm -f $TMPNAME"
echo $cmd
eval $cmd

exit $?

# TODO
