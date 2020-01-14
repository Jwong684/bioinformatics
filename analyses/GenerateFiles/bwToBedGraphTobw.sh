UCSCtools=/home/mbilenky/UCSCtools/
dirIn=/gsc/www/bcgsc.ca/downloads/ubc_vincenzo_Chip/drugs/mm10/
chromSizes=/home/mbilenky/UCSC_chr/mm10.chrom.sizes

cd $dirIn

#bw from bamCoverage (deeptools) does not convert into a viewable format (missing chr) on UCSC browser; so you need to convert bw to bedGraph then back to bw (using UCSC tools) to get the proper file

for bw in *bw
do
        echo Moving $bw to "tmp."$bw
        mv $bw "tmp."$bw
        name=${bw/.bw}
        echo Converting "tmp."$bw to $name".bedGraph"
        bigWigToBedGraph "tmp."$bw $name".bedGraph"
        echo Adding "chr" to $name".bedGraph"
        awk '{print "chr"$0}' $name".bedGraph" | grep -v chrG /dev/stdin | grep -v chrM | grep -v chrJ  > $name".chr.bedGraph"
        echo Converting $name".chr.bedGraph" to $bw
        bedGraphToBigWig $name".chr.bedGraph" $chromSizes $bw
        rm "tmp."$bw
        rm $name".chr.bedGraph"
done