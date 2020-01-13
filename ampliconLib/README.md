Amplicon library
================

To generate a bulk CRISPR-KO population within a cell line, I employed IDT's alt-R CRISPR ribonucleoprotein (RNP) electroporation system (https://www.idtdna.com/pages/products/crispr-genome-editing/alt-r-crispr-cas9-system) to transduce cells. Primers of which one side falls within 80bp of the CRISPR cut-site were generated with a NNNN barcode and Illumina adapters. DNA was extracted from cells across several passages and amplicon libraries were generated. The libraries were then pooled and spiked into the Illumina Miseq.

Fastq files were extracted and aligned to the reference amplicon sequence using the CRISPResso suite (https://github.com/lucapinello/CRISPResso). Reads with a Phred score of at least 30 were taken and indels were considered successful non-homologous end joining events if they occur within 1bp of the cut-site. Substitutions were ignored to provide a conservative estimate of knockout efficiency.

Dependencies:
-printseq-lite.pl
-cutadapt
-CRISPResso

[runall.sh](https://github.com/Jwong684/bioinformatics/tree/master/ampliconLib/runall.sh) will run all of the scripts in the order:
1) [makeList.sh](https://github.com/Jwong684/bioinformatics/tree/master/ampliconLib/makeList.sh) - generates a list of .fastq files to be processed.
2) [trim.sh](https://github.com/Jwong684/bioinformatics/tree/master/ampliconLib/trim.sh) - pipes the list into a function that collapses identical reads and trims barcodes using gnu parallel.
3) [makeList2.sh](https://github.com/Jwong684/bioinformatics/tree/master/ampliconLib/makeList2.sh) - generates a secondary list of trimmed .fastq files to be processed.
4) [CRISPResso.sh](https://github.com/Jwong684/bioinformatics/tree/master/ampliconLib/CRISPResso.sh) - pipes the secondary list into a function that aligns trimmed reads to a reference amplicon sequence and determines the proportion of edited cells based on the proportion of reads that have an indel around the cut-site.