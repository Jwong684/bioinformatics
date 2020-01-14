#!/bin/sh
java=/gsc/software/linux-x86_64/jre1.8.0_66/bin/java
LIB=/home/mbilenky/bin/Solexa_Java/
chr=/projects/epigenomics2/resources/UCSC_chr/mm10.bwa2ucsc.names
outBW=/home/jawong/src/DKO/bw/b2w2bw/rna_seq/
dirbam=/home/jawong/src/DKO/rna_seq/bam/
out=/home/jawong/src/DKO/rna_wig/

mkdir -p "$out"
mkdir -p "$outBW"

cd $dirbam

function parallel_b2w2bw {
        bamPath=$1
        tmp=''
        tmp=`basename $bamPath`
        IFS='.' read -r -a array <<< "$tmp"
        libName="${array[0]}"
        name=${tmp/.bam}
        outBW=/home/jawong/src/DKO/bw/b2w2bw/rna_seq/
        out=/home/jawong/src/DKO/rna_wig/
        LIB=/home/mbilenky/bin/Solexa_Java/
        chr=/projects/epigenomics2/resources/UCSC_chr/mm10.bwa2ucsc.names
        java=/gsc/software/linux-x86_64/jre1.8.0_66/bin/java
        $java -jar -Xmx80G $LIB/BAM2WIG.jar -bamFile $bamPath -out $out -q 5 -F 1028 -cp -n $name -chr $chr > $out$name.log
        /home/mbilenky/UCSCtools/wigToBigWig $out$name".q5.F1028.PET.wig.gz" /home/mbilenky/UCSC_chr/mm10.chrom.sizes $outBW$name.bw
}

export -f parallel_b2w2bw

cat rnaList.txt | parallel --gnu -j 6 parallel_b2w2bw