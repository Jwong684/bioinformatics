JAVA=/home/mbilenky/jdk1.8.0_92/jre/bin/java
LIB=/home/mbilenky/bin/Solexa_Java
csizes=/projects/epigenomics2/resources/UCSC_chr/mm10.chrom.sizes
dirw=/home/jawong/src/DKO/medip_wig/
dirOut=/home/jawong/src/DKO/medip/


for region in "CG_empty_500_chr"; do
        dirr=/projects/epigenomics2/resources/UCSC/mm10/CpG/gaps_500.bed
        for file in $dirw/*.wig.gz; do
                name=$(basename $file | sed -e 's/.q5.F1028.PET.wig.gz//g')
                out=$dirOut/$region/$name
                mkdir -p $out
                #for chr in {1..19} "X" "Y"; do
                        #chr="chr"$chr
                        #mkdir -p $out/$chr
                        echo $region $name #$chr
                        $JAVA -jar -Xmx15G $LIB/RegionsCoverageFromWigCalculator.jar -w $file -r $dirr -o $out -c $csizes -n $name
                        less $out/*.coverage | awk '{gsub("chr", "", $1); print $1"_"$2"\t"$4}' > $out/$chr"."$name.cov
                #done
        done
done