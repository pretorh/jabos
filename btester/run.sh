# check
if [ -z $1 ] ; then
    if [ -d `pwd`/tests ] ; then
        test_dir=`pwd`/tests
        echo "using tests in current directory ($test_dir)"
    else
        echo "No test root path specified"
        exit 1
    fi
elif ! [ -d $1 ] ; then
    echo "$1 is not a valid directory for the root of the tests"
    exit 1
elif [ "${1:$((${#1} - 1))}" == "/" ] ; then
    test_dir=${1:0:$((${#1} - 1))}
else
    test_dir=$1
fi

# prep
IFS=$'\n'
runner="`pwd`/$(dirname "${BASH_SOURCE[0]}")/.testrunner.sh"
summary_log="`pwd`/summary-`date --iso-8601`-`date +%H%M%S`.log"
touch $summary_log
test_count=`find $test_dir -type f -name '*.sh' | wc --lines`
tests=$(find $test_dir -type f -name '*.sh')

# print ? markers
echo -n "$test_count tests: "
for i in $(seq 1 $test_count) ; do
    echo -en "?"
done
echo -en "\r$test_count tests: "

# start
for f in $tests ; do
    $runner $f $summary_log ${f:${#test_dir} + 1} &
done

# wait for all to end
while [ `pgrep --parent $$ | wc -l` != "1" ] ; do
    child_count=$(($(pgrep --parent $$ | wc -l) - 1))
    sleep 0.25
done
echo ""

# print summary
err_count=`cat $summary_log | grep Fail | wc -l`
if [ $err_count == "0" ] ; then
    echo "No errors. $summary_log holds result order"
else
    echo -e "\E[31m$err_count errors\E[0m"
    cat $summary_log | grep Fail
fi

echo -e "\E[0m"
