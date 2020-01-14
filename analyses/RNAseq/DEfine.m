%/gsc/software/linux-x86_64-centos5/matlab-2013a/bin/matlab
addpath /home/mbilenky/matlab -end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out=true; corr1=true;corr2=true; figs=true; rpkm=true;minRPKM=0.01; minN=25; FDR=0.05;eps=0.001;maxLim=3.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% working directories
dirIn='/home/jawong/src/DKO/rna_seq/rpkm_nc_pc/';
dirOut='/home/jawong/src/DKO/rna_seq/DEG/DEfine_nc_pc/';
% RPKM files
% You would need to replace this part as it is reading the data : RPKM and N
libs={'72hr_R132H_vitc_rna','72hr_R132H_unt_rna'};
names={'72hr_R132H_vitc','72hr_R132H_unt'};
%
[id,n1,r1,rmi,ra,rma]=textread(strcat(dirIn,libs{1},'.pc.nc.rpkm'),'%s %f %f %f %f %f');
[id,n2,r2,rmi,ra,rma]=textread(strcat(dirIn,libs{2},'.pc.nc.rpkm'),'%s %f %f %f %f %f');
% Ensembl resources
% You would need to replace this part based on what organism and Ensembl annotations version were used
[idlg,l,g]=textread('/projects/epigenomics2/resources/Ensembl/mm38v84/mm38v84_exons_for_genes.L.GC','%s %f %f');
[ids,i1,i2]=intersect(id,idlg,'stable');
% Running DEfine
[cc,nfup,nfdn]=DEfine(ids, r1(i1), r2(i1), n1(i1), n2(i1), [l(i2),g(i2)], dirOut, names{1}, names{2}, out, figs, FDR, corr1, corr2, rpkm, minRPKM,minN,eps,maxLim);
