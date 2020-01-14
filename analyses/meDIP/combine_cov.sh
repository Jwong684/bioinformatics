dirIn=/home/jawong/src/DKO/medip/CG_25/
dirOut=/home/jawong/src/DKO/medip/cov/

mkdir -p $dirOut

for name in $dirIn/15hr*_medip; do
    echo $name
    regex="[^/]*$"
    name2=`echo $name | grep -oP "$regex"`
    echo $name2
    cat $name/*/*.cov > $dirOut/$name2.cov
done