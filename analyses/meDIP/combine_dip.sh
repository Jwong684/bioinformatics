dirIn=/home/jawong/src/DKO/medip/CG_25/
dirOut=/home/jawong/src/DKO/medip/
dir_list=`ls $dirIn`

for name in $dir_list; do
    echo $name
        bname=`basename $name`
        echo $bname
    cat $dirIn/$bname/*/*.dip > $dirOut/$bname.dip
done