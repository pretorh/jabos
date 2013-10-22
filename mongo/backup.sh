#! /bin/bash
# connect to the local running mongod instance, dump the specified database and tar-gzip it to a file based on the db name and date
# requires:
#   db name     name of the database to dump
set -e

if [ -z $1 ] ; then
    echo "need database name"
    exit 1
fi

db=$1

targzfile="dump-$db-`date --iso-8601`-`date +%H%M%S`.tar.gz"

rm -rf mongo.bak
mkdir mongo.bak
mongodump -vvvv --db $1 --out mongo.bak > mongo.bak/dump.log
du -bs mongo.bak | sed "s/\(\d*\)\t.*/\1 bytes uncompressed/"
GZIP=-9 tar czf $targzfile mongo.bak/
echo "`stat -c%s "$targzfile"` bytes compressed"
echo $targzfile
rm -r mongo.bak
