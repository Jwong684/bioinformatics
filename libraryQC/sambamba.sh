dirIn=/home/jawong/src/del7/bam/finalBams/
dirOut=/home/jawong/src/del7/bed4/1eneg5/
dirDefault=/home/jawong/src/del7/bed4/
sambamba=/gsc/software/linux-x86_64/sambamba-0.5.5/sambamba_v0.5.5

#objective: to find proportion of passed reads that fall within peaks

#ER summary file: name"\t"number of peaks"\t"length of peaks "\t" total number of passed reads "\t" number of passed reads in peaks "\t" average length of peaks "\t" fraction passed reads in peaks out of all peaks
for file in $dirIn/mutant*hmedip.bam; do
    sample=$(basename $file | sed 's/.bam//g')
    echo $sample
    macs2 callpeak -f BAMPE -g hs -t $file -q 0.01 -n $sample --outdir $dirOut
    n_all=$($sambamba view $file -c -F "not (unmapped or duplicate) and mapping_quality >= 5")
    less $dirOut/$sample"_peaks.narrowPeak" | sed 's/chr//g' > $dirIn/tmp.bed
    n_peak=$($sambamba view $file -c -F "not (unmapped or duplicate) and mapping_quality >= 5" -L $dirIn/tmp.bed)
    n_default=$($sambamba view $file -c -F "not (unmapped or duplicate) and mapping_quality >= 5" -L $dirDefault/$sample"_peaks.narrowPeak")
    echo -e $sample"\t"$(less $dirOut/$sample"_peaks.narrowPeak" | wc -l)"\t"$(less $dirOut/$sample"_peaks.narrowPeak" | awk '{s=s+$3-$2}END{print s}')"\t"$n_all"\t"$n_peak"\t"$n_default | awk '{print $0"\t"int($3/$2)"\t"$5/$4"\t"$6/$4}' >> $dirIn/hmedip_ER_summary.txt
    rm $dirIn/tmp.bed
done