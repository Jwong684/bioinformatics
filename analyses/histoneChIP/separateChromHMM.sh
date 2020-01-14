cd /home/jawong/src/matt/H3Kx_chip_oldlib/FindER_macs2_0.05/ChromHMM/ChromHMM_18state/

#unt
unt=/home/jawong/src/matt/H3Kx_chip_oldlib/FindER_macs2_0.05/ChromHMM/ChromHMM_18state/unt_18/
mkdir -p $unt
grep E1$ unt_18_segments.bed > $unt/H3K4me3.bed
grep E2 unt_18_segments.bed > $unt/H3K27me3_H3K4me3.bed
grep E3 unt_18_segments.bed > $unt/H3K27me3.bed
grep E4 unt_18_segments.bed > $unt/H3K27me3_H3K9me3.bed
grep E5 unt_18_segments.bed > $unt/H3K9me3.bed
grep E6 unt_18_segments.bed > $unt/H3K9me3_H3K36me3.bed
grep E7 unt_18_segments.bed > $unt/H3K36me3.bed
grep E8 unt_18_segments.bed > $unt/H3K36me3_H3K4me1.bed
grep E9 unt_18_segments.bed > $unt/H3K36me3_H3K4me3_H3K4me1.bed
grep E10 unt_18_segments.bed > $unt/H3K4me3_H3K4me1.bed
grep E11 unt_18_segments.bed > $unt/H3K4me3_H3K27ac_H3K4me1.bed
grep E12 unt_18_segments.bed > $unt/H3K4me3_H3K27ac.bed
grep E13 unt_18_segments.bed > $unt/H3K36me3_H3K4me3_H3K27ac.bed
grep E14 unt_18_segments.bed > $unt/H3K27ac.bed
grep E15 unt_18_segments.bed > $unt/H3K27ac_H3K4me1.bed
grep E16 unt_18_segments.bed > $unt/H3K4me1.bed
grep E17 unt_18_segments.bed > $unt/H3K27me3_H3K4me1.bed
grep E18 unt_18_segments.bed > $unt/none.bed

#vitc
vitc=/home/jawong/src/matt/H3Kx_chip_oldlib/FindER_macs2_0.05/ChromHMM/ChromHMM_18state/vitc_18/
mkdir -p $vitc
grep E1$ vitc_18_segments.bed > $vitc/H3K4me3.bed
grep E2 vitc_18_segments.bed > $vitc/H3K27me3_H3K4me3.bed
grep E3 vitc_18_segments.bed > $vitc/H3K27me3.bed
grep E4 vitc_18_segments.bed > $vitc/H3K27me3_H3K9me3.bed
grep E5 vitc_18_segments.bed > $vitc/H3K9me3.bed
grep E6 vitc_18_segments.bed > $vitc/H3K9me3_H3K36me3.bed
grep E7 vitc_18_segments.bed > $vitc/H3K36me3.bed
grep E8 vitc_18_segments.bed > $vitc/H3K36me3_H3K4me1.bed
grep E9 vitc_18_segments.bed > $vitc/H3K36me3_H3K4me3_H3K4me1.bed
grep E10 vitc_18_segments.bed > $vitc/H3K4me3_H3K4me1.bed
grep E11 vitc_18_segments.bed > $vitc/H3K4me3_H3K27ac_H3K4me1.bed
grep E12 vitc_18_segments.bed > $vitc/H3K4me3_H3K27ac.bed
grep E13 vitc_18_segments.bed > $vitc/H3K36me3_H3K4me3_H3K27ac.bed
grep E14 vitc_18_segments.bed > $vitc/H3K27ac.bed
grep E15 vitc_18_segments.bed > $vitc/H3K27ac_H3K4me1.bed
grep E16 vitc_18_segments.bed > $vitc/H3K4me1.bed
grep E17 vitc_18_segments.bed > $vitc/H3K27me3_H3K4me1.bed
grep E18 vitc_18_segments.bed > $vitc/none.bed