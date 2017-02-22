#!/usr/bin/env bash
# Release pkg template and configuration to nerv file
#$1 root dir to upload
#$2 file repository

if [ "$1" == "" ]; then
    echo "no dir to upload"
    exit 1
fi

if [ "$2" == "" ]; then
    echo "no file repository"
    exit 1
fi

FILE_REPOSITORY=$2


function upload() {
    #$1 file root
    #$2 file to upload
    local dir=${2%/*}
    cd $dir

    local path=${2##$1}
    path=${path%/*}
    local file=${2##*/}
    echo curl --form "uploadfile=@$file" $FILE_REPOSITORY$path
    curl --form "uploadfile=@$file" $FILE_REPOSITORY$path
}


function each_dir()  {
    #$1 file root
    #$2 parent dir
    #$3 func to do

    for file in $2/*
    do
        if [ -f $file ]; then
            $3 $1 $file
        fi
        if [ -d $file ]; then
            each_dir $1 $file $3
        fi
    done
}

each_dir $1 $1 upload