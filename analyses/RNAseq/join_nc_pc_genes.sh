dirOut=/home/jawong/src/DKO/rna_seq/rpkm_nc_pc/

mkdir -p $dirOut

dirIn=/home/jawong/src/DKO/rna_seq/rpkm/

for dir in $dirIn/*_rna/coverage/
do
        echo $dir
        dirName=$(dirname $dir)
        echo $dirName
        name=$(basename $dirName)
        echo $name
        cat $dir/*.G.A.rpkm.pc $dir/*.G.A.rpkm.nc | sort > $dirOut$name".pc.nc.rpkm"
done