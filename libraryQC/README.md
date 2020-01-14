Library Quality Checks (QC)
================

Processing .bam files after alignment:
1) indexing bam files
- uses gnu parallel and samtools to index all .bam files in a directory.
[index_bam.sh](https://github.com/Jwong684/bioinformatics/tree/master/libraryQC/index_bam.sh)

2) Alignment metrics - flagstats & bamstats
- bamstats (bwa) [bamstats.sh](https://github.com/Jwong684/bioinformatics/tree/master/libraryQC/bamstats.sh)
- flagstats (samtools) [flagstats.sh](https://github.com/Jwong684/bioinformatics/tree/master/libraryQC/flagstats.sh)

3) PETlength distribution
- check the range of PETlengths in library (employs a lab-generated script)
[PETlengthDis.sh](https://github.com/Jwong684/bioinformatics/tree/master/libraryQC/PETlengthDis.sh)
- R code to compile and graph out PETlength distributions in density graph

4) QC peak calling
- Number of peaks (from MACS2 peak caller) using various q-value cut-offs
[peakQC.sh](https://github.com/Jwong684/bioinformatics/tree/master/libraryQC/peakQC.sh) - generates a table that shows the number of peaks called at different q-value cut-offs after using MACS2 for all libraries within a directory. Can be used to determine a q-value cut-off for peak calling (i.e. find the q-value in which the change in number of peaks has plateaued).
- Proportion of reads that fall within peaks [sambamba.sh](https://github.com/Jwong684/bioinformatics/tree/master/libraryQC/sambamba.sh) - uses sambamba to determine the proportion of passed reads that fall within a peak called by MACS2.
