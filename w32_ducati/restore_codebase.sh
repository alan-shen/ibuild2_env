#!/bin/bash
#Created by guoshujuan 2013.12.3

if [ -z "$1" ];then
    CODEBASE_PATH=`pwd`
else
    CODEBASE_PATH=`readlink -f $1`
fi

if [ ! -f $CODEBASE_PATH/change_list.txt ]; then
    echo "Do NOT find change_list.txt"
    echo "Please unzip check_attach.7z under $CODEBASE_PATH"
    exit
fi
cd $CODEBASE_PATH
REV=`svn info | grep Revision | awk -F' ' '{print $2}'`
cat change_list.txt | awk -F' ' '{print $2}' | xargs -i rm -rf {}
cat change_list.txt | awk -F' ' '{print $2}' | xargs -i svn up -r $REV {}
cat change_list.txt | awk -F' ' '{print $2}' | xargs -i svn status {}
