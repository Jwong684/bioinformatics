#making a list matching R1, R2 etc.
#TET2
for fq in trimmed*TET2*R_1.fastq
do
        name=${fq/R_1.fastq}
        read1=$name"R_2.fastq"
        echo -e "$fq\t$read1" >> TET2AD_trimList.txt
done

#TET3
for fq in trimmed*TET3*R_1.fastq
do
        name=${fq/R_1.fastq}
        read1=$name"R_2.fastq"
        echo -e "$fq\t$read1" >> TET3AM_trimList.txt
done