CRISPResso=/home/jawong/src/programs/centos_env/bin/CRISPResso-master/CRISPResso.py
in=/home/jawong/src/TET2KO/20190111_amplicons/
out=/home/jawong/src/TET2KO/20190111_amplicons/CRISPResso/
python=/home/jawong/src/TET2KO/20190111_amplicons/pythonEnv/bin/python

mkdir -p $out

cd $in

#requires: CRISPResso suite and python environment
#input: a list of trimmed fastq files, amplicon reference, gRNA
function TET2AD {
        python=/home/jawong/src/TET2KO/20170927_amplicons/pythonEnv/bin/python
        out=/home/jawong/src/TET2KO/20190111_amplicons/CRISPResso/
        in=/home/jawong/src/TET2KO/20190111_amplicons/
        CRISPResso=/home/jawong/src/programs/centos_env/bin/CRISPResso-master/CRISPResso.py
        tmp=$1
        r1=`echo $tmp | tr " " "\n" | head -1`
        r2=`echo $tmp | tr " " "\n" | tail -1`
        echo $r1 and $r2
        name=`echo $r1 | sed -e 's/R_1.fastq/R/g'`
        $python $CRISPResso -r1 $r2 -a TCCCAACACGGAACTACAATGGAGTTGAAATTCAGGTTCTCAACGAGCAGGAAGGGGAAAAAGGCAGGAGCGTTACATTA -g AATTCAGGTTCTCAACGAGC --hide_mutations_outside_window_NHEJ -q 30 --output_folder $out -p 10 --ignore_substitutions -c TCCCAACACGGAACTACAATGGAGTTGAAATTCAGGTTCTCAACGAGCAGGAAGGGGAAAAAGGCAGGAGCGTTACATTA
}
export -f TET2AD
cat TET2AD_trimList.txt | parallel --gnu -j 20 TET2AD >> TET2AD_CRISPResso_summary.log

function TET3AM {
        python=/home/jawong/src/TET2KO/20170927_amplicons/pythonEnv/bin/python
        out=/home/jawong/src/TET2KO/20190111_amplicons/CRISPResso/
        in=/home/jawong/src/TET2KO/20190111_amplicons/
        CRISPResso=/home/jawong/src/programs/centos_env/bin/CRISPResso-master/CRISPResso.py
        tmp=$1
        r1=`echo $tmp | tr " " "\n" | head -1`
        r2=`echo $tmp | tr " " "\n" | tail -1`
        echo $r1 and $r2
        name=`echo $r1 | sed -e 's/R_1.fastq/R/g'`
        $python $CRISPResso -r1 $r1 -a TGCTCGTCTGGAAGATGCCCACGACCTGGTGGCCTTTTCGGCCGTGGCCGAAGCTGTGTCATCTTACGGGGCCCTTAGTA -g TCTGGAAGATGCCCACGACC --hide_mutations_outside_window_NHEJ -q 30 --output_folder $out -p 10 --ignore_substitutions -c TGCTCGTCTGGAAGATGCCCACGACCTGGTGGCCTTTTCGGCCGTGGCCGAAGCTGTGTCATCTTACGGGGCCCTTAGTA
}
export -f TET3AM
cat TET3AM_trimList.txt | parallel --gnu -j 20 TET3AM >> TET3AM_CRISPResso_summary.log