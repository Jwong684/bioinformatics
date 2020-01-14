dir=/home/jawong/src/DKO/bam/72hr/
out=$dir/flagstats/

mkdir -p "$out"

cd "$dir"

for file in *.bam

do
        mkdir "$out"

        echo $file

        name=${file/.bam}

        samtools flagstat $dir$file > $out$name".flagstat.txt"

done