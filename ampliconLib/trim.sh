#pipes a list of files into a custom function that collapses identical reads (printseq-lite.pl) 
# and then trims the reads for the illumina tag and the NNNN barcode (cutadapt)
#requires: printseq-lite.pl and cutadapt
#for TET2
function Kut {
        tmp=$1
        r1=`echo $tmp | tr " " "\n" | head -1`
        r2=`echo $tmp | tr " " "\n" | tail -1`
        echo $r1 and $r2
        name=`echo $r1 | sed -e 's/R1_001.fastq/R/g'`
        perl ./printseq-lite.pl -fastq $r1 -fastq2 $r2 -phred64 -derep 1 -out_format 3 -out_good $name -out_bad null
        /gsc/software/linux-x86_64-centos5/python-2.7.5/bin/cutadapt -O 10 -g NNNNGAGACACC -G NNNNTAATGTAA -o "trimmed_${name}_1.fastq" -p "trimmed_${name}_2.fastq" "${name}_1.fastq" "${name}_2.fastq"
}
export -f Kut
cat TET2AD_origList.txt | parallel --gnu -j 20 Kut >> TET2AD_trim_summary.log

#for TET3
function Kut2 {
        tmp=$1
        r1=`echo $tmp | tr " " "\n" | head -1`
        r2=`echo $tmp | tr " " "\n" | tail -1`
        echo $r1 and $r2
        name=`echo $r1 | sed -e 's/R1_001.fastq/R/g'`
        perl ./printseq-lite.pl -fastq $r1 -fastq2 $r2 -phred64 -derep 1 -out_format 3 -out_good $name -out_bad null
        /gsc/software/linux-x86_64-centos5/python-2.7.5/bin/cutadapt -O 10 -g NNNNACGCTGCT -G NNNNGTGGTTTC -o "trimmed_${name}_1.fastq" -p "trimmed_${name}_2.fastq" "${name}_1.fastq" "${name}_2.fastq"
}
export -f Kut2
cat TET3AM_origList.txt | parallel --gnu -j 20 Kut2 >> TET3AM_trim_summary.log