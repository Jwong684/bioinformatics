dirIn=/gsc/www/bcgsc.ca/downloads/ubc_vincenzo_Chip/drugs/mm10/
n1=0
n2=0
n3=0

cd $dirIn

for bw in *bw
do
        echo $bw
        name=${bw/.bw}
        echo -e "track\t"$name"\nshortLabel\t"$name"\nlongLabel\t"$name"\ntype\tbigWig\nvisibility\tfull\nmaxHeightPixels\t70:70:32\nconfigurable\ton\nautoScale\ton\nalwaysZero\ton\npriority\t1\nbigDataUrl\t"$bw"\ncolor\t"$n1","$n2","$n3"\n" >> $dirIn/trackDb.txt
        n1=$(($n1+$((1+ RANDOM % 255))))
        n2=$(($n2+$((1+ RANDOM % 255))))
        n3=$(($n3+$((1+ RANDOM % 255))))
done