addpath /home/mbilenky/matlab/dmr -end

close all; clear all;
set(0,'defaultaxesfontsize',18,'defaultlinelinewidth',2);
names={'72hr_R132H_unt_medip',  '72hr_R132H_vitc_medip',  '72hr_TET2KO_unt_medip',  '72hr_TET2KO_vitc_medip',  '72hr_TET3KO_unt_medip',  '72hr_TET3KO_vitc_medip'};
chrs={'chr1','chr2','chr3','chr4','chr5','chr6','chr7','chr8','chr9','chr10','chr11','chr12','chr13','chr14','chr15','chr16','chr17','chr18','chr19','chrX','chrY'};

for i = 1:6
    name=names{1,i};
    for j = 1:21
        chr=chrs{1,j}
        close all;
        [l,cc] = textread(['/home/jawong/src/DKO/medip/CG_25/',name,'/',chr,'/',chr,'.',name,'.cov'],'%s %f');
        [c,n,cn] = textread(['/home/jawong/src/DKO/medip/CG_empty_500_chr/',name,'/gaps_500.bed.',name,'.covDist'],'%f %f %f');

        x=c;
        y=cn/max(cn);
        z=cc;
        dip=medip_score2(x,y,z);

        figure('visible','off');box;
        cdfplot(dip);
        xlabel('Fractional methylation');
        ylabel('Fraction of CpGs');
        title(strcat(name,'.',chr));
        dirOut='/home/jawong/src/DKO/medip/CDF_5mC_plots/';
        nameOut=strcat(dirOut, 'CDF_5mC_',name,'.',chr);
        print(gcf, '-dpdf', strcat(nameOut, '.pdf'));

        t=size(dip); n=t(2);
        fileOut = fopen(strcat('/home/jawong/src/DKO/medip/CG_25/',name,'/',chr,'/',chr,'.',name,'.dip'),'w');
        for i=1:n
fprintf(fileOut,'%s\t', l{i});
fprintf(fileOut,'%7.3f\t',dip(i));
fprintf(fileOut,'\n');
        end
        fclose(fileOut);
    end
end