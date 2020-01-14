JAVA=/home/mbilenky/jdk1.8.0_92/jre/bin/java
LIB=/home/mbilenky/bin/Solexa_Java
csizes=/home/jawong/mm10/mm10.bwa.w.chr.noGJM.sizes
dirw=/home/jawong/src/DKO/medip_wig/
dirOut=/home/jawong/src/DKO/medip/

#============================================
# ./RegionsCoverageFromWigCalculator
#=============================================

#OUTPUT FORMAT (non-verbose): *.coverage
#       Fields 1-3: chr, region start, region end
#       Next field(s): any 'IDs' in the region file
#       Following field: Normalized/average coverage (Total coverage / region length)
#       Last field: Maximal coverage in the region

for region in "CG_25"; do
        dirr=/projects/epigenomics2/resources/UCSC/mm10/CpG/$region/
        echo Entering into the realm of $dirr
        for file in $dirw/*.wig.gz ; do
                name=$(basename $file | sed -e 's/.q5.F1028.PET.wig.gz//g')
                out=$dirOut/$region/$name
                mkdir -p $out
                echo Making... $out using the corresponding file of $name in $file
                echo Beep booop boop ... Running.............
                for chr in {1..19} "X" "Y"; do
                        chr2="chr"$chr
                        mkdir -p $out/$chr2
                        echo $region $name $chr2
                        $JAVA -jar -Xmx15G $LIB/RegionsCoverageFromWigCalculator.jar -w $file -r $dirr/$chr -o $out/$chr2 -c $csizes -n $name
                        less $out/$chr2/*.coverage | awk '{gsub("chr", "", $1); print $1"_"$2"\t"$4}' > $out/$chr2/$chr2"."$name.cov
                done
        done
done