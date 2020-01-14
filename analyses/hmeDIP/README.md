hmeDIP-seq pipeline
================

hmeDIP-seq is a technique for determining genomic regions that have the DNA modification 5hmC within a population. 5hmC is an oxidized form of 5mC and is detected at less than 1% of the level of 5mC.

hmeDIP-seq data are often represented in concentrated areas around the genome. On a genome browser, it would show up as sharp, punctate peaks, similar to transcription factor ChIP-seq data.

As a result, a simple peak caller (MACS2) can be used to determine all enriched regions across the genome with high confidence. To determine differentially 5hmC-marked regions between two conditions, we generate a union file of peaks, and employ deeptools to measure the signal density at these peaks. We can then do a pairwise comparison of signal density and use both a signal and fold-change cutoff to determine differentially 5hmC-marked peaks.

Differentially 5hmC-marked analysis pipeline:
1) [callPeaks](https://github.com/Jwong684/bioinformatics/tree/master/analyses/hmeDIP/callPeaks.sh) (5hmC-immunoprecipitated DNA) - uses MACS2 to call narrow-peaks for every hmeDIP-seq library.

2) [DHR_call](https://github.com/Jwong684/bioinformatics/tree/master/analyses/hmeDIP/DHR_call.sh) - uses depptools RPKM-normalized bigWig files to calculate signal density at peaks; uses a fold-change and signal cut-off to determine differentially marked regions.
