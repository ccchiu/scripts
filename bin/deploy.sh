#!/bin/sh 
# prepare tmp dir
DIR=/home/jerry/tmp/build_out
WORK_DIR=/home/jerry/WORK/pdsall.git
GIT_EXPORT=$HOME/bin/git_export
WWW=/LIN_WWW
BUILD_TIME=`date +%Y%m%d_%H%M%S`;
GIT_V=`git log --pretty=format:'%h' |head -1`
export WORK_DIR

if [ "$PWD" != "$WORK_DIR" ]; then
    echo "You are not in working dir."
    echo "using [cd $WORK_DIR ]";
    exit;
fi

if [ -d "$DIR" ]; then
    rm -rf $DIR;
fi

#git export out
$GIT_EXPORT -f $DIR

#cp web to lin
echo "Clean LIN_WWW";
rm -rf  $WWW/*
echo "Copy to Lin_WWW";
cp -Rf $DIR/web/* $WWW
sed -e  's/define(\"DEV\",1);/define(\"DEV\",0);/g' -e 's/define(\"PRODUCTION\",0);/define(\"PRODUCTION\",1);/g' $WWW/config.php > /tmp/ddd.l

sed -e 's/bbbst/'$BUILD_TIME'('$GIT_V')/g' $WWW/index.html > /tmp/iii.l
cat /tmp/iii.l > $WWW/index.html
cat /tmp/ddd.l > $WWW/config.php

chmod -R 777 $WWW/db

