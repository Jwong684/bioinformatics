#ChromHMM script:


#Step 1: binarization
echo binarization

/gsc/software/linux-x86_64/jre1.8.0_66/bin/java -Xmx5G -jar /projects/epigenomics/users/amoussavi/software/ChromHMM/v1.14/ChromHMM/ChromHMM.jar BinarizeBed -peaks /projects/epigenomics/users/amoussavi/software/ChromHMM/v1.14/ChromHMM/CHROMSIZES/mm10.txt /home/jawong/src/matt/H3Kx_chip_oldlib/FindER_macs2_0.05/ /home/jawong/src/matt/H3Kx_chip_oldlib/FindER_macs2_0.05/marktable /home/jawong/src/matt/H3Kx_chip_oldlib/FindER_macs2_0.05/ChromHMM/


#Step 2: learn model
echo learn

/gsc/software/linux-x86_64/jre1.8.0_66/bin/java -Xmx25G -jar /projects/epigenomics/users/amoussavi/software/ChromHMM/v1.14/ChromHMM/ChromHMM.jar LearnModel -b 200 -p 16 /home/jawong/src/matt/H3Kx_chip_oldlib/FindER_macs2_0.05/ChromHMM/ /home/jawong/src/matt/H3Kx_chip_oldlib/FindER_macs2_0.05/ChromHMM/ChromHMM_18state/ 18 mm10


/gsc/software/linux-x86_64/jre1.8.0_66/bin/java -Xmx25G -jar /projects/epigenomics/users/amoussavi/software/ChromHMM/v1.14/ChromHMM/ChromHMM.jar LearnModel -b 200 -p 16 /home/jawong/src/matt/H3Kx_chip_oldlib/FindER_macs2_0.05/ChromHMM/ /home/jawong/src/matt/H3Kx_chip_oldlib/FindER_macs2_0.05/ChromHMM/ChromHMM_15state/ 15 mm10

#makeSegments (from IHEC model instead of learning a model from n = 1)