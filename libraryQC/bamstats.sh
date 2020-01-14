dir=/home/jawong/src/DKO/bam/72hr/
out=/home/jawong/src/DKO/bam/72hr/bamstats/
bamstat=/gsc/QA-bio/sbs-solexa/opt/linux-x86_64/bwa_stats_0.1.3/bamStats.py

#mkdir -p "$out"

cd "$dir"

for file in *.bam

do
        mkdir "$out"

        name=${file/.bam}

        echo $file

        $bamstat -b $dir$file > $out$name".bamstat.txt"

done