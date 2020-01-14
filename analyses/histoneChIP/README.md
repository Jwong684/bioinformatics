Histone ChIP-seq
================

Histone ChIP-seq data were analysed using the MACS2 peak caller - with narrowPeaks being used for H3K27ac and H3K4me3 and broadPeaks being used for H3K36me3, H3K9me3, H3K4me1, H3K27me3.

ChromHMM was used to annotate the genome based on the presence or absence of histone combinations.

[marktable](https://github.com/Jwong684/bioinformatics/tree/master/analyses/histoneChIP/marktable) - table used by ChromHMM to assign cell-type and treatment-type for each library

[binarizeLearn.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/histoneChIP/binarizeLearn.sh) - ChromHMM script used to bin the genome and assign a binary label based on the presence or absence of a given histone mark and then train the model using either a 15 state or 18 state model (as per IHEC standards)

[separateChromHMM.sh](https://github.com/Jwong684/bioinformatics/tree/master/analyses/histoneChIP/separateChromHMM.sh) - separates ChromHMM states into separate bed files.