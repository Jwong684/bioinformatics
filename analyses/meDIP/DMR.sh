################### initial set up ###################
m=0.75    # fractional methylation of one sample need to > m
delta=0.6 # minimum difference in fractional calls to call DM CpG
size=300  # max distance between two consecutive CpGs
cut=4     # minimum number of CpGs

#sample
#=============================
# ./DMR.sh -w /home/jawong/src/drugs/medip_bed/ -a mut_vitc_medip -b mut_unt_medip -t vitc -f unt -c mut

while getopts "w:a:b:d:n:t:f:c:m:l:" opt; do
        case $opt in
                w) dirIn=$OPTARG;;
                a) file1=$OPTARG;;
                b) file2=$OPTARG;;
                d) dirOut=$OPTARG;;
                n) dirName=$OPTARG;;
                t) treatment1=$OPTARG;;
                f) treatment2=$OPTARG;;
                c) cell1=$OPTARG;;
                m) cell2=$OPTARG;;
                l) libs=$OPTARG;;
                \?)
                        echo "Invalid option: -$OPTARG" >&$2
                        ;;
        esac
done

name1=${file1/.dip}
name2=${file2/.dip}

echo $file1 and $file2
echo $name1 and $name2

if [ -z "$dirIn" ] ; then dirIn=/home/jawong/src/drugs/realign/medip/ ; fi
if [ -z "$dirName" ] ; then dirName=$name1"vs"$name2 ; fi
if [ -z "$treatment2" ] ; then treatment2=$treatment1 ; fi
if [ -z "$cell2" ] ; then cell2=$cell1 ; fi
if [ -z "$libs" ] ; then libs="medip" ; fi

echo $cell1 and $cell2
echo $treatment1 and $treatment2
echo $libs

cd $dirIn
dirOut=$dirIn/DMR/$dirName/
mkdir -p $dirOut
> $dirOut/DMR.summary.stats
> $dirOut/DM.summary.stats
################### library information ###################
lib1=$libs; cell1=$cell1; donor1=$treatment1; name1=$name1;
lib2=$libs; cell2=$cell2; donor2=$treatment2; name2=$name2;
################### fixed code for each pairwise comparison from here on ###################
name=$cell1"-"$donor1"_"$cell2"-"$donor2
dm=DM.$name.m$m.d$delta.bed
echo -e DMRs between $cell1"-"$donor1 and $cell2"-"$donor2: m=$m, delta=$delta, size=$size, cut=$cut, output: chr"\t"start"\t"end"\t"ID"\t"DM"\t"No.of CpGs"\t"length
paste $dirIn/$name1.dip $dirIn/$name2.dip | awk -v delta=$delta -v m=$m '{if($1!=$3)print "Bad line", $0; chr="chr"gensub("_[0-9]+", "", "g", $1); start=gensub("[0-9XY]+_",
 "", "g", $1)+23; end=start+2; if($2-$4 > delta && $2>m)print chr"\t"start"\t"end"\t1\t"$2"\t"$4; else if($2-$4 < -delta && $4>m)print chr"\t"start"\t"end"\t-1\t"$2"\t"$4}'
 | sort -k1,1 -k2,2n > $dirOut/$dm
less $dirOut/$dm | grep 'Bad line'
Ndm=($(wc -l $dirOut/$dm)); Nhyper=($(less $dirOut/$dm | awk '{if($4==1){c=c+1}} END{print c}')); Nhypo=($(less $dirOut/$dm | awk '{if($4==-1){c=c+1}} END{print c}'))
echo -e $name"\t"$m"\t"$delta"\t"$Ndm"\t"$Nhyper"\t"$Nhypo >> $dirOut/DM.summary.stats
/home/lli/HirstLab/Pipeline/shell/DMR.dynamic.sh -i $dirOut -o $dirOut -f $dm -n $name.m$m.d$delta -s $size -c $cut