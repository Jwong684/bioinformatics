meDIP-seq pipeline
================

meDIP-seq is a technique for determining genomic regions that have the DNA modification 5mC within a population. DNA methylation at regulatory regions (such as promoters and enhancers) are classically associated with the suppression of their associated gene.

Methylation was determined by partitioning the genome into regions with CpGs (±25bp) and regions devoid of CpGs (±500bp) and measuring the meDIP-seq signal at each of these regions. A custom script was used to generate an empirical cumulative distribution function of CpG regions against CpG-empty regions. A fractional methylation value was then assigned for each CpG by using the CpG-empty regions as a background from which mC signal can be measured at CpG sites.
Differentially methylated regions were called by comparing the fractional methylation signals at each CpG between two libraries. A minimum fractional methylation of 0.75 and a minimum difference of 0.6 in fractional calls were used as a cut-off to determine differentially methylated CpGs. The differentially methylated CpGs were then stitched together dynamically within a 300bp window to form differentially methylated regions, with a minimum of 4 CpGs within each region.

Differentially 5mC-marked analysis pipeline: [runall.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/meDIP/runall.sh) runs all of the following scripts

1) [CG25_RegionsCoverageFromWigCalculator.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/meDIP/CG25_RegionsCoverageFromWigCalculator.sh) - uses a custom java script to calculate the raw coverage (from a wiggle .wig file) of 5mC signal based on a reference CG+/-25bp bed file.
output: Coverage (.cov) files of every chromosome highlighting the raw coverage of meDIP signal at CG+/-25bp regions

2) [CG_empty_500_chr.RegionsCoverageFromWigCalculator.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/meDIP/CG_empty_500_chr.RegionsCoverageFromWigCalculator.sh) - uses a custom java script to calculate the raw coverage (from a wiggle .wig file) of 5mC signal based on a reference CG-empty (500 bp) bed file.
output: Coverage (.cov) files of every chromosome highlighting the raw coverage of meDIP signal at CG empty regions

3) [medip_score.m](https://github.com/Jwong684/bioinformatics/tree/master/analyses/meDIP/medip_score.m) - uses depptools RPKM-normalized bigWig files to calculate signal density at peaks; uses a fold-change and signal cut-off to determine differentially marked regions.
output: fractional methylation (.dip) files of every CpG bin for each chromosome.

4) [combine_cov.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/meDIP/combine_cov.sh) - concatenate all .cov files.

5) [combine_dip.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/meDIP/combine_dip.sh) - concatenate all .dip files.

6) [DMR.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/meDIP/DMR.sh) - customizable DMR caller (allows for pairwise comparisons between either cell type or treatment groups)
Uses an in-lab DMR caller (that calculates methylation differences for every CpG bin between two libraries, essentially binarizing whether a CpG is differentially methylated or not, then stitching differentially methylated CpGs together in a 300bp window to create a DMR)