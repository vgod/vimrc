#!/usr/bin/env bash
#
# Usage: buildme.sh [TAG]
# - TAG: a string composed of REPO:IMG

IMG="circlelychen/dev"
TAG=vim-$(date '+%Y%m%d')

# build base and vim containers
docker build -t $IMG:base -f docker/base.dockerfile .
docker build -t $IMG:$TAG -f docker/vim.dockerfile .

cmd="docker push $IMG:$TAG"
echo $cmd
eval $cmd

exit $?

# TODO
