if [ -z "$5" ] ; then
    echo "Need params: workDir appDir projectCodeName debugHomeActivtyClass releaseHomeActivtyClass"
    exit 1
fi

workDir=$1
appDir=$2
projectCodeName=$3
debugHomeActivtyClass=$4
releaseHomeActivtyClass=$5

cd $workDir

p="n"
while [ "$p" != "y" ]
do
    echo "=== dev loop ==="
    gradle installDebug
    if [ $? != 0 ]
    then
        echo "build fail. enter to build again"
        read
    else
        echo "launching"
        adb shell am start -n $debugHomeActivtyClass -a android.intent.action.MAIN -c android.intent.category.LAUNCHER
        
        echo -n "y to continue to release build, any other to loop (build and prompt again) (y/..) "
        read p
    fi
done

p="n"
while [ "$p" == "n" ]
do
    echo "=== build/install release apk ==="
    gradle assembleRelease
    if [ $? != 0 ]
    then
        echo "build fail"
        exit 2
    fi
    
    
    version=`grep "android:versionCode" $appDir/build/manifests/release/AndroidManifest.xml | perl -pe 's#.*versionCode="(\d+?)".*#\1#'`
    echo "This is version $version"

    mkdir -p release
    file_id="$projectCodeName-release-$version-`date --iso-8601`-`date +%H%M`"
    tar -czf "release/$file_id-proguardlogs.tar.gz" -C "$appDir/build/proguard/release/" "."
    cp $appDir/build/apk/$appDir-release.apk release/$file_id.apk
    
    echo "installing..."
    adb install -r release/$file_id.apk
    adb shell am start -n $releaseHomeActivtyClass -a android.intent.action.MAIN -c android.intent.category.LAUNCHER
    
    echo -n "n to build again, any other to complete (n/..) "
    read p
done

echo "=== done ==="
