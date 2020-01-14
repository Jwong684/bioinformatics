out=/home/jawong/src/del7/bam/finalBams/realign/

mkdir -p $out

function realign2 {
        bamPath=$1
        tmp=''
        tmp=`basename $bamPath`
        IFS='.' read -r -a array <<< "$tmp"
        libName="${array[0]}"
        name=${tmp/.bam}
        out=/home/jawong/src/del7/bam/finalBams/realign/
        in=/home/jawong/src/del7/bam/finalBams/
        echo $name

        cd $in
        samtools sort -n $bamPath $name"_sorted"

        mv $in/$name"_sorted.bam" $out/

        cd $out

       bedtools bamtofastq -i $out/$name"_sorted.bam" \
                      -fq $out/$name"1.fq" \
                      -fq2 $out/$name"2.fq"

        chrom=/home/jawong/src/drugs/bam/tmp/mm10_build38_mouse.fasta
        /home/pubseq/BioSw/bwa/bwa-0.7.5a/bwa mem -t 12 -M $chrom $out/$name"1.fq" $out/$name"2.fq" > $out/$name".bwamem.sam"
        #sorting and marking dups
        samtools view -Sb $out/$name".bwamem.sam" > $out/$name".bwamem.bam"
        samtools sort $out/$name".bwamem.bam" $out/$name".bwamem.sorted"

        java -jar -Xmx10G /home/pubseq/BioSw/picard/picard-tools-1.52/MarkDuplicates.jar I=$out/$name".bwamem.sorted.bam" O=$out/$name".bwamem.sorted.dups_marked.bam" M=dups AS=true VALIDATION_STRINGENCY=LENIENT QUIET=true
        samtools flagstat $out/$name".bwamem.sorted.dups_marked.bam" > $out/$name".bwamem.sorted.dups_marked.flagstat"

        rm $out/$name"1.fq" 
        rm $out/$name"2.fq" 
        rm $out/$name".bwamem.sam"
        rm $out/$name".bwamem.bam"
        rm $out/$name".bwamem.sorted.bam"
}

#create a bamList.txt that lists all bams you want realigned
export -f realign2
cat bamList.txt | parallel --gnu -j 4 realign2