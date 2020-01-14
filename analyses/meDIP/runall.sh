dirIn=/home/jawong/src/DKO/medip/

cd $dirIn

#calculates coverage (using wiggle .wig over CpG +/- 25bp regions)
./CG25_RegionsCoverageFromWigCalculator.sh
#calculates coverage (using wiggle .wig over CpG-empty 500bp regions)
./CG_empty_500_chr.RegionsCoverageFromWigCalculator.sh

mkdir -p CDF_5mC_plots/

#generate fractional methylation files (.dip) and CDF plots
/gsc/software/linux-x86_64-centos5/matlab-2013a/bin/matlab -nodisplay -nodesktop -r "run medip_score.m; quit"

mkdir -p cov/

#concatenate all coverage (all chr) into one file for each library
./combine_cov.sh
#concatenate all fractional methylation (all chr) into one file for each library
./combine_dip.sh

#call differential methylation between two libraries
#input commands: -w input directory -a name of lib1 (no .dip) -b name of lib2 (no .dip) 
# optional: 
# -t treatment1 -f treatment2 (if no input for -f, then automatically assume same treatment)
# -c celltype1 -m celltype2 (if no input for -c, then automatically assume same treatment)
#72hr_DKO_unt_medip  72hr_DKO_vitc_medip  72hr_R132H_unt_medip  72hr_R132H_vitc_medip  72hr_TET2KO_unt_medip  72hr_TET2KO_vitc_medip  72hr_TET3KO_unt_medip  72hr_TET3KO_vitc_medip
./DMR.sh -w /home/jawong/src/DKO/medip/ -a 72hr_R132H_vitc_medip -b 72hr_R132H_unt_medip -t vitc -f unt -c R132H
./DMR.sh -w /home/jawong/src/DKO/medip/ -a 72hr_TET2KO_vitc_medip -b 72hr_TET2KO_unt_medip -t vitc -f unt -c TET2KO
./DMR.sh -w /home/jawong/src/DKO/medip/ -a 72hr_TET3KO_vitc_medip -b 72hr_TET3KO_unt_medip -t vitc -f unt -c TET3KO
./DMR.sh -w /home/jawong/src/DKO/medip/ -a 72hr_DKO_vitc_medip -b 72hr_DKO_unt_medip -t vitc -f unt -c DKO

#relative to R132H unt
./DMR.sh -w /home/jawong/src/DKO/medip/ -a 72hr_TET2KO_unt_medip -b 72hr_R132H_unt_medip -t unt -c TET2KO -m R132H
./DMR.sh -w /home/jawong/src/DKO/medip/ -a 72hr_TET3KO_unt_medip -b 72hr_R132H_unt_medip -t unt -c TET3KO -m R132H
./DMR.sh -w /home/jawong/src/DKO/medip/ -a 72hr_DKO_unt_medip -b 72hr_R132H_unt_medip -t unt -c DKO -m R132H

#relative to IDHwt
./DMR.sh -w /home/jawong/src/DKO/medip/ -a 72hr_R132H_unt_medip -b IDHwt_unt_medip -t unt -c R132H -m IDHwt
./DMR.sh -w /home/jawong/src/DKO/medip/ -a 72hr_TET2KO_unt_medip -b IDHwt_unt_medip -t unt -c TET2KO -m IDHwt
./DMR.sh -w /home/jawong/src/DKO/medip/ -a 72hr_TET3KO_unt_medip -b IDHwt_unt_medip -t unt -c TET3KO -m IDHwt
./DMR.sh -w /home/jawong/src/DKO/medip/ -a 72hr_DKO_unt_medip -b IDHwt_unt_medip -t unt -c DKO -m IDHwt