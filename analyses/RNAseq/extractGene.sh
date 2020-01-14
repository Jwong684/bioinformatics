dirIn=/home/jawong/src/DKO/rna_seq/DEG/DEfine_nc_pc/

for file in UP*
do
        name=${file/.FDR_0.05.rmin_0.01.Nmin_25}
        sort $file | join ~/src/resources/Ensembl/mm10v81/mm10v81_genes.EnsID_sorted.NAME /dev/stdin > wrangled/$name".name"
done

for file in DN*
do
        name=${file/.FDR_0.05.rmin_0.01.Nmin_25}
        sort $file | join ~/src/resources/Ensembl/mm10v81/mm10v81_genes.EnsID_sorted.NAME /dev/stdin > wrangled/$name".name"
done