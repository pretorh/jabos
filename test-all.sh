if [ "$1" == "--clean" ] || [ "$1" == "--clean-after" ] ; then
    echo "removing old log files"
    find -name \*.log -print0 | xargs -0 rm
fi

./btester/run.sh
success=$?
mv summary*.log tests/

if [ "$1" == "--clean-after" ] && [ $success == 0 ] ; then
    echo "removing all log files"
    find -name \*.log -print0 | xargs -0 rm
fi
