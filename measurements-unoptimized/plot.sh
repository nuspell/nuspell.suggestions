if [ ! -e graphs ]; then
    mkdir graphs
fi
if [ ! -e gnuplots ]; then
    mkdir gnuplots
fi
for LOG_PATH in logs/*.log.*; do
    LOG=$(basename $LOG_PATH .log)
    if [ ! -s $LOG_PATH ]; then
        rm -f gnuplots/$LOG.plt graphs/$LOG.png
        continue
    fi
    if [ gnuplots/$LOG.plt -nt $LOG_PATH ]; then
        continue
    fi
    SIZE=$(wc -l $LOG_PATH|awk '{print $1}')
    TSV=$(echo $LOG|awk -F '.log' '{print $1}').tsv
    WORDS=$(wc -l $TSV|awk '{print $1}')
    SIZE=$(wc -l $LOG_PATH|awk '{print $1}')
    TITLE=$(echo $LOG|sed -e 's/_/\\\\_/g'|sed -e 's/.log./---'$WORDS'\\\\_words---'$SIZE'\\\\_measurements---/g')
    MAX=$(sort -n $LOG_PATH|tail -n 1)
    if [ $(echo $LOG|grep -c _attempts) -eq 0 ]; then
        if [ $(echo $LOG|grep -c _size) -eq 0 ]; then
            XLABEL=nanoseconds
        else
            XLABEL=size
        fi
    else
        XLABEL=attempts
    fi
    sed -e 's/NAME/'$LOG'/g' ../templates/histogram | \
    sed -e 's/TITLE/'$TITLE'/g' | \
    sed -e 's/MAX/'$MAX'/g' | \
    sed -e 's/XLABEL/'$XLABEL'/g' | \
    sed -e 's/SIZE/'$SIZE'/g' > gnuplots/$LOG.plt
    echo $LOG
    gnuplot gnuplots/$LOG.plt
done
