set -e

to=`xmlstarlet sel -t -v "/settings/encrypt-recipient" ../testdata.xml`
rm -f *.gpg
file=`../../security/gpgcrypt.sh gpgcrypt-test.sh $to`
if [ -f "$file" ]; then
    echo "created $file"
    rm "$file"
else
    echo "expected file $file not found"
    exit 1
fi
