rm -f *png

for i in ../measurements-optimized/graphs/*png; do
    j=$(basename $i)
    if [ $(echo $j|grep -c nl.log) -ne 0 -o $(echo $j|grep -c fr.log) -ne 0 ]; then
        continue
    fi
    echo $j
    convert -append ../measurements-unoptimized/graphs/$j $i $j
done
