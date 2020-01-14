mkdir -p PETlength

## note for input: "/home/mbilenky/bin/PETLengthDist.sh <1: input BAM file (full path)> <2: quality threshold (integer >=0)> <3: output directory path> <4: N reads to output progress (in millions)>" 

## output: 2 files: 
#1) .dist highlights the proportion of each PETlength in library:
#"<p1=position of left 1/2 mod> <percentile of p1> <mod> <percentile of mod> <p2=position of left 1/2 mod> <percentile of p2> <median>"

#2) .dist.summary contains one-line 
#"<p1=position of left 1/2 mod> <percentile of p1> <mod> <percentile of mod> <p2=position of left 1/2 mod> <percentile of p2> <median>"

for bam in */*.bam
do
        echo "Processing" $bam
        /home/mbilenky/bin/PETLengthDist.sh $bam 5 PETlength 10
done