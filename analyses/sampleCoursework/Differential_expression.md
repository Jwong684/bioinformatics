Differential\_expression
================
Jasper Wong
March 3, 2017

I. Foreword:
============

This document contains the code/figures created based on analyses of differentially expressed genes in AML and LGG patients from TCGA, subsetted into IDH-mutants and IDH-WT groups.

This document is an exploratory look into patterns between IDH mutants and IDH wt patients in AML and LGG cohorts.

1. Heatmaps for expression patterns within diseases:
====================================================

AML:
----

Let's look at initial correlations of expression within the 173 patient cohort.

``` r
suppressPackageStartupMessages(library(dplyr))
suppressWarnings(library(pheatmap))

#Input 2017-04-03
index.allzero.lgg <- apply(data.rna.lgg, 1, function(x) all(x == 0))
index.allzero.aml <- apply(data.rna.aml, 1, function(x) all(x == 0))
data.rna.aml.nonzero <- data.rna.aml[!index.allzero.aml,]
data.rna.lgg.nonzero <- data.rna.lgg[!index.allzero.lgg,]

matrix_aml_rna <- as.matrix(data.rna.aml.nonzero) %>% cor(method = "spearman")
diag(matrix_aml_rna) <- NA
```

Let's divide these cohorts into IDH mutants and nonIDH mutants

``` r
suppressPackageStartupMessages(library(tibble))
```

    ## Warning: package 'tibble' was built under R version 3.3.3

``` r
library(ggplot2)
```

    ## Warning: package 'ggplot2' was built under R version 3.3.2

``` r
aml_patients_IDH_sorted <- data.aml.label %>%
    arrange(IDH) %>%
    column_to_rownames("Sample.ID")

annotation_row_aml = data.frame(as.character(aml_patients_IDH_sorted$IDH))
rownames(annotation_row_aml) = rownames(aml_patients_IDH_sorted)
colnames(annotation_row_aml) = "IDH"

matrix_aml_rna_IDHsorted <- matrix_aml_rna[rownames(annotation_row_aml), rownames(annotation_row_aml)]

#annotated heatmap with IDH and non IDH mutants:
pheatmap(matrix_aml_rna_IDHsorted, cluster_rows = T , cluster_cols = T, annotation_row = annotation_row_aml, annotation_col = annotation_row_aml,show_rownames = F, show_colnames = F)
```

![](Differential_expression_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
#Let's look at how these IDH mutants and IDH wt groups cluster with a PCA.

#creating PCs
pcs.data.rna.aml <- data.rna.aml[,rownames(table.mut.aml)] %>% t() %>% 
    prcomp()
plot(pcs.data.rna.aml)
```

![](Differential_expression_files/figure-markdown_github/unnamed-chunk-3-2.png)

``` r
ggplot(as.data.frame(pcs.data.rna.aml$x), 
             aes(x = PC1, y = PC2, color = table.mut.aml$IDH)) +
    geom_point()
```

![](Differential_expression_files/figure-markdown_github/unnamed-chunk-3-3.png)

Interestingly, there isn't anything noteworthy in IDH mutants in AML. However, there is IDH1 and IDH2 mutants and within IDH1, there are multiple subtypes.

``` r
aml_patients_IDH_sorted_subtypes <- table.IDH %>%
    dplyr::filter(Cancer.Study == "AML (TCGA pub)") %>% 
    arrange(Mutation.subtype, AA.change)

#there are two patients with BOTH IDH1 and IDH2 mutation

aml_patients_IDH_sorted_subtypes[5,3] <- "IDH1/2" 
levels(aml_patients_IDH_sorted_subtypes) <- droplevels(aml_patients_IDH_sorted_subtypes$AA.change)
```

    ## Warning in `levels<-`(`*tmp*`, value = structure(c(1L, 1L, 1L, 1L, 1L,
    ## 1L, : duplicated levels in factors are deprecated

``` r
aml_patients_IDH_sorted_subtypes$AA.change <- as.character(aml_patients_IDH_sorted_subtypes$AA.change)
aml_patients_IDH_sorted_subtypes[5,4] <- "R132C/R172K"

#remove the duplicate (convoluted way to go about it)
aml_patients_IDH_sorted_subtypes[35,] <- NA
aml_patients_IDH_sorted_subtypes <-
  aml_patients_IDH_sorted_subtypes[complete.cases(aml_patients_IDH_sorted_subtypes),]

#likewise for the second one
aml_patients_IDH_sorted_subtypes[6,3] <- "IDH1/2"
aml_patients_IDH_sorted_subtypes[6,4] <- "R132C/R172K"
aml_patients_IDH_sorted_subtypes[35,] <- NA
aml_patients_IDH_sorted_subtypes <-
  aml_patients_IDH_sorted_subtypes[complete.cases(aml_patients_IDH_sorted_subtypes),]


rownames(aml_patients_IDH_sorted_subtypes) <- NULL
aml_patients_IDH_sorted_subtypes <- aml_patients_IDH_sorted_subtypes %>% column_to_rownames("Sample.ID")

#now to sort them in the heatmap
#this is to filter out specifc IDHmut patients in the original dataset
aml_patients_IDH_sorted_subtypes <- aml_patients_IDH_sorted_subtypes %>% 
  rownames_to_column("sample1") %>% 
  filter(rownames(aml_patients_IDH_sorted_subtypes) %in% rownames(annotation_row_aml)) %>% 
  column_to_rownames("sample1")

#to create a new annotation based on IDH types
annotation_row_aml_IDH_sorted =
  data.frame(as.character(aml_patients_IDH_sorted_subtypes$Mutation.subtype),
                                           as.character(aml_patients_IDH_sorted_subtypes$AA.change))
rownames(annotation_row_aml_IDH_sorted) = rownames(aml_patients_IDH_sorted_subtypes)
colnames(annotation_row_aml_IDH_sorted) = c("IDH", "subtype")
#rearrange the annotation list based on IDH and subtype
annotation_row_aml_IDH_sorted <- annotation_row_aml_IDH_sorted %>%
  rownames_to_column("sample1") %>% 
  arrange(IDH, subtype) %>% 
  column_to_rownames("sample1")

#only way to create a new matrix (you can't do rownames(); there will be an OOB error (fatal))
matrix_aml_rna_IDHsorted_subtype <- 
  matrix_aml_rna[rownames(matrix_aml_rna) 
                 %in% row.names(annotation_row_aml_IDH_sorted),
                 colnames(matrix_aml_rna) %in%
                   row.names(annotation_row_aml_IDH_sorted)]

#rearrange the matrix based on annotation order again
matrix_aml_rna_IDHsorted_subtype <-
  matrix_aml_rna_IDHsorted_subtype[rownames(annotation_row_aml_IDH_sorted),
                                   rownames(annotation_row_aml_IDH_sorted)]

#let's focus specifically on IDH mutants in AML and their subtypes (to see if there's any patterns that arise)
pheatmap(matrix_aml_rna_IDHsorted_subtype, cluster_rows = T, cluster_cols = T, annotation_row = annotation_row_aml_IDH_sorted, annotation_col = annotation_row_aml_IDH_sorted, show_rownames = F, show_colnames = F)
```

![](Differential_expression_files/figure-markdown_github/unnamed-chunk-4-1.png)

``` r
#there appears to be no discernible pattern
```

LGG:
----

Let's do the same thing with LGG: ![](Differential_expression_files/figure-markdown_github/unnamed-chunk-5-1.png)![](Differential_expression_files/figure-markdown_github/unnamed-chunk-5-2.png)![](Differential_expression_files/figure-markdown_github/unnamed-chunk-5-3.png)

    ## Warning: Removed 1 rows containing missing values (geom_point).

![](Differential_expression_files/figure-markdown_github/unnamed-chunk-5-4.png)
