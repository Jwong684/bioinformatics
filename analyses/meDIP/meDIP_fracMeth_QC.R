# R script to examine the signal vs background ratio of meDIP-seq libraries using ECDF curves 
# we leverage the fact that we know the location of every CpG in the genome, and measure the signal of meDIP (methylated DNA immunoprecipitation)
# at regions that have CpGs against regions (CpG coordinate +/-25bp) that do not have CpGs (500bp bins)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(reshape2)
library(tibble)
library(pheatmap)
library(VennDiagram)
library(UpSetR)
library("overLapPlot", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.3")
library(hexbin)
library(data.table)
library(MIPHENO)

setwd("/home/jawong/src/DKO/medip/ecdf_QC/")

#directory of coverage in regions that contain CpG (cov_adaptive) and directory of coverage of regions that are empty of CpGs (cov_empty)
cov_adaptive <- list.files(path = "/home/jawong/src/DKO/medip/ecdf_QC/CG_25/", pattern="coverage", full.names = T)
cov_empty <- list.files(path = "/home/jawong/src/DKO/medip/ecdf_QC/CG_empty_500_chr/", pattern="coverage", full.names = T)

# names of every meDIP library 
cells <- c("15hr_DKO_unt_medip",   "15hr_R132H_unt_medip",   "15hr_TET2KO_unt_medip",   "15hr_TET3KO_unt_medip",   "72hr_DKO_unt_medip",   "72hr_R132H_unt_medip",   "72hr_T
ET2KO_unt_medip",   "72hr_TET3KO_unt_medip",
"15hr_DKO_vitc_medip",  "15hr_R132H_vitc_medip",  "15hr_TET2KO_vitc_medip",  "15hr_TET3KO_vitc_medip",  "72hr_DKO_vitc_medip",  "72hr_R132H_vitc_medip",  "72hr_TET2KO_vitc_
medip",  "72hr_TET3KO_vitc_medip")

#adaptive CpG bins
cov_all <- fread(cov_adaptive[1], select = 4) %>% setnames(cells[1])
for(i in 2:length(cov_adaptive)) {
  temp <- fread(cov_adaptive[i], select = 4)
  colnames(temp) <- c(cells[i])
  cov_all <- cbind(temp, cov_all)
  rm(temp)
}

#empty CpG bins
cov_back <- fread(cov_empty[1], select = 4) %>% setnames(cells[1])
for(i in 2:length(cov_empty)) {
  temp <- fread(cov_empty[i], select = 4)
  colnames(temp) <- c(cells[i])
    cov_back <- cbind(temp, cov_back)
}

#combining the two tables
master_ecdf <- rbind(
gather(cov_all, key = lib, value = cov) %>% mutate(group = "CG"),
gather(cov_back, key = lib, value = cov) %>% mutate(group = "empty")
)

#generating an ECDF plot of coverage vs background of every library (faceted)
pdf(file = "medip_ecdf.pdf", width = 12, height = 17, family = "Helvetica")
ggplot(master_ecdf, aes(cov, colour = group)) + stat_ecdf(pad = FALSE) + facet_wrap(~lib) + xlim(0, 20) + theme(text = element_text(size = 20))
dev.off()