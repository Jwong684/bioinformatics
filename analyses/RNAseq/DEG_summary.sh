for txt in *vitc*txt
do
        num=$(cat $txt | wc -l)
        deg=${txt/.*}
        name2=${txt/_*}
        timepoint=${name2#*.}
        name4=${txt#*_};
        cell=${name4/_*};
        echo -e "$num\t$deg\t$timepoint\t$cell" >> DEG_pc.txt
done