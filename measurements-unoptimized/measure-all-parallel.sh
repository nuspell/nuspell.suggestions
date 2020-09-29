for i in *tsv; do
    export TSV=$i
    ./measure.sh &
done
