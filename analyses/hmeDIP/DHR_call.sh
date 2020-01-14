#macs2 to call peaks
#use the union file of both (pairwise DMR)
#calculate cov at each region for pair
#fold enrichment cut-off (FC > 2 AND coverage of numerator > 20)

function uniqueER {
    export PATH=/home/rislam/anaconda2/bin/:$PATH
    export PYTHONPATH=/home/rislam/anaconda2/lib/python2.7/site-packages
    BEDTOOLS=/gsc/software/linux-x86_64-centos5/bedtools/bedtools-2.25.0/bin/
    dirER=/home/jawong/src/DKO/hmedip/union/
    dirBed=/home/jawong/src/DKO/hmedip/
    dirBW=/home/jawong/src/DKO/bw/bamCoverage/
    dirOut=/home/jawong/src/DKO/hmedip/union/DMR_fc/
    sample1=$1; sample2=$2; name=$sample1'_'$sample2
    echo $sample1 $sample2 $name
    cat $dirBed/$sample1'_peaks_1eneg5_narrowPeak.filtered' $dirBed/$sample2'_peaks_1eneg5_narrowPeak.filtered' | sort -k1,1 -k2,2n | $BEDTOOLS/mergeBed -i stdin -c 4 -o collapse > $dirER/$name'.union.narrowPeak'
    multiBigwigSummary BED-file -b $dirBW/$sample1.bw $dirBW/$sample2.bw --BED $dirER/$name'.union.narrowPeak' --labels $sample1 $sample2 -out $dirOut/$name'.union.npz' --outRawCounts $dirOut/$name'.union.RPKM'
    less $dirOut/$name'.union.RPKM' | awk 'NR>1 && $1 !~ /GL/ {fc=($4+0.001)/($5+0.001); if(fc>2&&$4>20){print "chr"$1"\t"$2"\t"$3"\t"$1":"$2"-"$3"\t"$4"\t"$5"\t"fc}}' | sort -k1,1 -k2,2n > $dirOut/$name"."$sample1".unique.bed"
    echo -e $sample1"\t"$sample2"\t"$sample1"\t"$(less $dirBed/$sample1'_peaks_1eneg5_narrowPeak.filtered' | wc -l)"\t"$(less $dirBed/$sample2'_peaks_1eneg5_narrowPeak.filtered' | wc -l)"\t"$(less $dirOut/$name"."$sample1".unique.bed" | wc -l)"\t"$(less $dirOut/$name"."$sample1".unique.bed" | awk '{s=s+$3-$2}END{print s}') >> $dirOut/ER_unique_summary.txt
    less $dirOut/$name'.union.RPKM' | awk 'NR>1 && $1 !~ /GL/ {fc=($5+0.001)/($4+0.001); if(fc>2&&$5>20){print "chr"$1"\t"$2"\t"$3"\t"$1":"$2"-"$3"\t"$4"\t"$5"\t"fc}}' | sort -k1,1 -k2,2n > $dirOut/$name"."$sample2".unique.bed"
    echo -e $sample1"\t"$sample2"\t"$sample2"\t"$(less $dirBed/$sample1'_peaks_1eneg5_narrowPeak.filtered' | wc -l)"\t"$(less $dirBed/$sample2'_peaks_1eneg5_narrowPeak.filtered' | wc -l)"\t"$(less $dirOut/$name"."$sample2".unique.bed" | wc -l)"\t"$(less $dirOut/$name"."$sample2".unique.bed" | awk '{s=s+$3-$2}END{print s}') >> $dirOut/ER_unique_summary.txt
}
export uniqueER
dirOut=/home/jawong/src/DKO/hmedip/union/DMR_fc/
mkdir -p $dirOut
#compiles the stats of every pair-wise comparison in a text file (ER_unique_summary.txt)
echo -e "Sample1\tSample2\tunique\tN_ER1\tN_ER2\tN_unique\tlength_unique" > $dirOut/ER_unique_summary.txt

#simple comparisons (how to use: uniqueER <library name 1> <library name 2>)
#library name = filename without "_peaks_1eneg5_narrowPeak.filtered"
#hmedip
#15hr vitc
uniqueER 15hr_R132H_vitc_hmedip 15hr_R132H_unt_hmedip
uniqueER 15hr_TET2KO_vitc_hmedip 15hr_TET2KO_unt_hmedip
uniqueER 15hr_TET3KO_vitc_hmedip 15hr_TET3KO_unt_hmedip
uniqueER 15hr_DKO_vitc_hmedip 15hr_DKO_unt_hmedip
#72hr vitc
uniqueER 72hr_R132H_vitc_hmedip 72hr_R132H_unt_hmedip
uniqueER 72hr_TET2KO_vitc_hmedip 72hr_TET2KO_unt_hmedip
uniqueER 72hr_TET3KO_vitc_hmedip 72hr_TET3KO_unt_hmedip
uniqueER 72hr_DKO_vitc_hmedip 72hr_DKO_unt_hmedip

#comparative hydroxymethylome
uniqueER 15hr_TET2KO_unt_hmedip 15hr_R132H_unt_hmedip
uniqueER 15hr_TET3KO_unt_hmedip 15hr_R132H_unt_hmedip
uniqueER 15hr_DKO_unt_hmedip 15hr_R132H_unt_hmedip
uniqueER 72hr_TET2KO_unt_hmedip 72hr_R132H_unt_hmedip
uniqueER 72hr_TET3KO_unt_hmedip 72hr_R132H_unt_hmedip
uniqueER 72hr_DKO_unt_hmedip 72hr_R132H_unt_hmedip