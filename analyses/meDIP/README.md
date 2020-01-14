meDIP-seq pipeline
================

meDIP-seq is a technique for determining genomic regions that have the DNA modification 5mC within a population. DNA methylation at regulatory regions (such as promoters and enhancers) are classically associated with the suppression of their associated gene.

Methylation was determined by partitioning the genome into regions with CpGs (±25bp) and regions devoid of CpGs (±500bp) and measuring the meDIP-seq signal at each of these regions. A custom script was used to generate an empirical cumulative distribution function of CpG regions against CpG-empty regions. A fractional methylation value was then assigned for each CpG by using the CpG-empty regions as a background from which mC signal can be measured at CpG sites.
Differentially methylated regions were called by comparing the fractional methylation signals at each CpG between two libraries. A minimum fractional methylation of 0.75 and a minimum difference of 0.6 in fractional calls were used as a cut-off to determine differentially methylated CpGs. The differentially methylated CpGs were then stitched together dynamically within a 300bp window to form differentially methylated regions, with a minimum of 4 CpGs within each region.

Differentially 5mC-marked analysis pipeline:
1) [callPeaks](https://github.com/Jwong684/bioinformatics/tree/master/analyses/hmeDIP/callPeaks.sh) (5mC-immunoprecipitated DNA) - uses MACS2 to call narrow-peaks for every hmeDIP-seq library.

2) [DHR_call](https://github.com/Jwong684/bioinformatics/tree/master/analyses/hmeDIP/DHR_call.sh) - uses depptools RPKM-normalized bigWig files to calculate signal density at peaks; uses a fold-change and signal cut-off to determine differentially marked regions.
