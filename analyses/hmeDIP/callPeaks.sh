dirIn=/home/jawong/src/DKO/bam/
dirOut=/home/jawong/src/DKO/hmedip/

mkdir -p $dirOut

cd $dirIn

## callpeaks
for bam in */*hmedip.bam
do
        name=$(basename $bam)
        name2=${name/.bam}
        macs2 callpeak -t $bam -f BAMPE -g mm -n $name2 --outdir $dirOut -p 0.1
done

cd $dirOut

## set a cut-off based on q-value, remove peaks that align to chrG, chrM, chrJ
for narrowPeak in *narrowPeak
do
        name2=${narrowPeak/.narrowPeak}
        awk '{print "chr"$1"\t"$2"\t"$3"\t"10^-$9}' $narrowPeak | awk '($4 < 1e-5)' /dev/stdin | grep -v chrG /dev/stdin | grep -v chrM | grep -v chrJ  > $name2"_1eneg5_narrowPeak.filtered"
done