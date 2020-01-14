#!/bin/bash
echo -e "name\tq\tnum_peaks" > CDF_peaks.txt

calc(){ awk "BEGIN { print $*}"; }

for narrowPeak in *narrowPeak
do
        name2=${narrowPeak/.narrowPeak}
        echo $name2
        for i in {10..1}
        do
        num=$(calc 1e-$i)
        length=$( awk '{print "chr"$1"\t"$9}' $narrowPeak |  grep -v chrG /dev/stdin | grep -v chrM | grep -v chrJ  | awk -v var="$i" '($2 > var)'  |  wc -l )
        echo -e $num
        echo -e $length
        echo -e "$name2\t$num\t$length" >> CDF_peaks.txt
        done
done