Generate processed files pipeline
================

This folder shows pipelines used to process .bam files into other biological files:

1) [bam2wig2bw.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/GenerateFiles/bam2wig2bw.sh)

I optimized an existing pipeline using gnu parallel to run through multiple bam files at once and generate wig and bigwig files.

input: 
a list of .bam files

output: 
wig files generated from .bam
bigwig files generated from .wig

- wiggle (.wig) for base-pair raw coverage
- bigWig (.bw) [derived from wiggle] for visualization (from raw coverage)

2) [bamCoverage.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/GenerateFiles/bamCoverage.sh)

I used bamCoverage to generate bigWigs with normalized signal used for determining signal density at genomic regions

- bigWig (.bw) normalized to library depth [derived from .bam using deepTools suite] to be used to measure signal density


3) [bwToBedGraphTobw.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/GenerateFiles/bwToBedGraphTobw.sh)

To display deeptools bw files on the UCSC genome browser, we need to convert the bw to a bedGraph file (and append "chr") and then revert it back to a bw. This tool uses a for loop to convert all bw in a directory for that purpose.

4) [makeTrackDB.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/GenerateFiles/makeTrackDB.sh)

Used to generate a trackDB for the UCSC genome browser. This automatically assigns a random colour to the track.

5) [makeTrackDB_multi.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/GenerateFiles/makeTrackDB_multi.sh)

With the newer versions of the UCSC genome browser, you can now group multiple .bw files together. This script generates a grouped trackDB file.

6) [realignBam2fastq2bam.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/GenerateFiles/realignBam2fastq2bam.sh)

Used to realign a bam file using bwa mem. Converts bam to fastq (for paired end libraries), then realigns, sorts, and dup-mark the realigned bam file. Done in parallel. Need to be careful about memory usage for this script.

