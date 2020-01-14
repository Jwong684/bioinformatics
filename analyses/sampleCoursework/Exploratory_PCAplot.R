rm(list = ls())
setwd("~/Documents/STAT540_GroupRepo/data/raw data")
library(dplyr)
library(ggplot2)
library(ggbiplot)

load("IDHanalysisData.rdata")

################################Exploratory: PCA################################
###LGG
result.pca.lgg <- t(data.rna.lgg) %>% prcomp(scale = T)

ggbiplot(result.pca.lgg, choices = 1:2, groups = table.mut.lgg$IDH, var.axes = F) + 
  scale_color_discrete(name = "IDH Mutation") +
  ggtitle("LGG: PCA with All Genes") +
  theme(plot.title = element_text(hjust = 0.5),
        text = element_text(size=20))

###AML
result.pca.aml <- t(data.rna.aml) %>% prcomp(scale = T)

ggbiplot(result.pca.aml, choices = 1:2, groups = table.mut.aml$IDH, var.axes = F) + 
  scale_color_discrete(name = "IDH Mutation") +
  ggtitle("AML: PCA with All Genes") +
  theme(plot.title = element_text(hjust = 0.5),
        text = element_text(size=20))