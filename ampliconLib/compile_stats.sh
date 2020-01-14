dirIn=/home/jawong/src/Ping/CRISPResso_v1.0.12_output/

cd $dirIn

echo -e "Name\tUnmod\tNHEJ\tGroup" > $dirIn/NHEJ_stats.txt

for dir in /home/jawong/src/Ping/CRISPResso_v1.0.12_output/*/*
do
        echo $dir
        dirName=$(basename $dir | sed 's/^CRISPResso_on_//g')
        parentDir=$(dirname $dir)
        parentDirName=$(basename $parentDir)
        echo $parentDir
        echo $parentDirName
        unmod=$(less $dir/Quantification_of_editing_frequency.txt | cut -d ":" -f2 | awk '{print $1}' | awk '(NR > 1)' | sed '1q;d')
        NHEJ=$(less $dir/Quantification_of_editing_frequency.txt | cut -d ":" -f2 | awk '{print $1}' | awk '(NR > 1)' | sed '2q;d')
        echo $dirName
        echo $unmod
        echo $NHEJ
        echo -e "$dirName\t$unmod\t$NHEJ\t$parentDirName" >> $dirIn/NHEJ_stats.txt
done