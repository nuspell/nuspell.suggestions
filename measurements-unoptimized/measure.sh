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
grep 'priv_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.priv_suggest
grep 'priv_suggest_size ' $DICT.log|awk '{print $2}' \
> $DICT.log.priv_suggest_size
grep 'uppercase_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.uppercase_suggest
grep 'rep_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.rep_suggest
grep 'map_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.map_suggest
grep 'map_suggest_attempts ' $DICT.log|awk '{print $2}' \
> $DICT.log.map_suggest_attempts
grep 'adjacent_swap_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.adjacent_swap_suggest
grep 'distant_swap_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.distant_swap_suggest
grep 'keyboard_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.keyboard_suggest
grep 'extra_char_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.extra_char_suggest
grep 'forgotten_char_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.forgotten_char_suggest
grep 'forgotten_char_suggest_attempts ' $DICT.log|awk '{print $2}' \
> $DICT.log.forgotten_char_suggest_attempts
grep 'move_char_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.move_char_suggest
grep 'bad_char_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.bad_char_suggest
grep 'bad_char_suggest_attempts ' $DICT.log|awk '{print $2}' \
> $DICT.log.bad_char_suggest_attempts
grep 'doubled_two_chars_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.doubled_two_chars_suggest
grep 'two_words_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.two_words_suggest
grep 'phonetic_suggest ' $DICT.log|awk '{print $2}' \
> $DICT.log.phonetic_suggest
head -n 1 $DICT.log > $DICT.out
tail -n 55 $DICT.log >> $DICT.out
cd ..
