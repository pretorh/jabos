file=$1
summary_log=$2
display_name=$3
D=`dirname "$1"`
F=`basename "$1"`
out_log="`date --iso-8601`-`date +%H%M%S`_$F.log"

cd "$D"
"./$F" 2&>$out_log
if [ $? != 0 ]
then
    echo "Fail $display_name" >> $summary_log
    cat $out_log >> $summary_log
    echo -en "\E[31mX\E[0m"
    exit 1
else
    echo " OK  $display_name" >> $summary_log
    cat $out_log >> $summary_log
    echo -en "\E[32m\u2714\E[0m"
fi
