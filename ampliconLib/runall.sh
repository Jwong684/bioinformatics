#dirIn should contain all your .fastq files
dirIn=/home/jawong/src/TET2KO/20190424_amplicons/

cd $dirIn

#make an origList.txt (for each CRISPR-target)
#only needs to align to one read
#TET2 R2
#TET3 R2
./makeList.sh

#trim.sh contains printseq and cutadapt
#printseq will collapse duplicates based on NNNN
#cutadapt will cut out the NNNN adapters
./trim.sh

#make a trimList.txt
./makeList2.sh

#CRISPRESSO only needs fastq files - it aligns the fastq to a reference amplicon sequence
./CRISPResso.sh