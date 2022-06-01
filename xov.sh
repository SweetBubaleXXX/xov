#!/bin/sh

name="xov"

function help {
    echo $'
    -e [editor] : where to open,
    -l(oad) : pull,
    -u(pload) : push\n'
    git status -s
}

function encrypt {
    gpg --yes --armor --output $file --pinentry-mode=loopback --symmetric --cipher-algo AES256 ./.$name/$file
}

function decrypt {
    gpg --yes --armor --output ./.$name/$file --pinentry-mode=loopback --cipher-algo AES256 --decrypt $file
}

function openfile {
    if [ -z $editor ]
    then
        vim -u ".vim-config" ./.$name/$file
    else
        $editor ./.$name/$file
    fi
}

function load {
    git pull
    git reset --hard
}

function upload {
    upload_time=`date +%c`
    git stash
    git pull
    git stash pop
    git add -A
    git commit -m "$upload_time"
    git push origin HEAD:main
}

while getopts e:luh flag
do
    case ${flag} in 
    e) editor=${OPTARG};;
    l) load; exit;;
    u) upload; exit;;
    h) help; exit;;
    esac
done
shift $((OPTIND-1))

if [ -z $1 ]
then
    file=`date +%y-%m-%d`
else
    file=$1
fi

rm -rf ./.$name
mkdir ./.$name

if [ -s $file ]
then
    decrypt
fi

openfile
encrypt

rm -rf ./.$name
