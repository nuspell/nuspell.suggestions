if [ -z $TSV ]; then
    echo Missing environment variable TSV
    exit
fi

DICT=$(basename $TSV .tsv)
start=`date +%s`
./nuspell/build/tests/verify -q -d ../dicts/$DICT -c $TSV > logs/$DICT.log 2>&1
end=`date +%s`
echo -n 'Total Time ' >> logs/$DICT.log
echo $end-$start|bc >> logs/$DICT.log

cd logs
cp -f $DICT.log $DICT.out
cd ..
