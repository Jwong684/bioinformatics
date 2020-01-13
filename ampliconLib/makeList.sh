#making a list matching R1, R2 etc.
#TET2AD (this list will be used to pipe into trimming for downstream processing)
for fq in *TET2*_001.fastq
do
        name=${fq/R1_001.fastq}
        read1=$name"R2_001.fastq"
        echo -e "$fq\t$read1" >> TET2AD_origList.txt
done

#TET3AM
for fq in *TET3*_001.fastq
do
       name=${fq/R1_001.fastq}
        read1=$name"R2_001.fastq"
        echo -e "$fq\t$read1" >> TET3AM_origList.txt
done