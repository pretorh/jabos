#! /bin/bash

../../mongo/backup.sh
if [ $? == 0 ] ; then
    echo "must error for no params"
    exit 1
fi

../../mongo/backup.sh test
if [ $? != 0 ] ; then exit 1 ; fi
rm -rf dump-*.tar.gz
