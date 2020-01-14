dirBW=/home/jawong/src/DKO/bw/bamCoverage/

mkdir -p $dirBW

cd /home/jawong/src/DKO/bam/72hr/

for bam in *bam
do
name=${bam/.bam}
bamCoverage -b $bam -o $dirBW/$name".bw" --normalizeUsingRPKM --ignoreDuplicates --samFlagExclude 1028 --minMappingQuality 5 --binSize 20 --extendReads
done