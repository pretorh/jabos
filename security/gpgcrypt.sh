set -e

if [ -z $1 ] || ! [ -f $1 ] ; then
    echo "Need file to encrypt as first parameter"
    exit 1
fi
if [ -z "$2" ] ; then
    echo "Need recipients as 2+ parameter"
    exit 1
fi

recipientList=""
for recipient in "${@:2}" ; do
    recipientList="$recipientList --recipient $recipient"
done

in=$1
out=$in.gpg

gpg --output "$out" \
    --trust-model always \
    --encrypt \
    $recipientList \
    "$in"

echo $out
