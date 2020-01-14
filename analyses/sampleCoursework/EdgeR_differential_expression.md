EdgeR\_differential\_expression
================
Jasper Wong
March 22, 2017

Foreword:
=========

This is a continuation of Differential\_expression.Rmd. The primary difference here is that the DE analysis is done using EdgeR instead of voom.

Loading datasets: (using write.excel() function that copies from clipboard)

``` r
#copying them from clipboard #took them from Jie's DE_IDH_lgg.xlsx and DE_IDH_aml.xlsx overlapping_fc tabs

library(readxl)

DE_IDH_lgg_FC1 <- read_excel("../../Results_edgeR/DE_IDH_lgg.xlsx", 3)
DE_IDH_aml_FC1 <- read_excel("../../Results_edgeR/DE_IDH_aml.xlsx", 3)

#graphing out logFC vs FDR for:
#aml:
ggplot(DE_IDH_aml_FC1, aes(x = logFC, y = FDR)) + geom_point()
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-2-1.png)

``` r
#lgg:
ggplot(DE_IDH_lgg_FC1, aes(x = logFC, y = FDR)) + geom_point()
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-2-2.png)

``` r
#comparing logFC between AML and LGG
logFC1_aml_lgg <- merge(DE_IDH_aml_FC1[,1:3], DE_IDH_lgg_FC1[,1:3], 
                        by = c("Hugo_Symbol", "Entrez_Gene_Id"))
colnames(logFC1_aml_lgg) <- c("Hugo_Symbol","Entrez_Gene_Id","logFC.aml", "logFC.lgg")

#filter it out based on Hugo or Entrez
logFC1_aml_lgg <- logFC1_aml_lgg %>% 
  dplyr::select(-Entrez_Gene_Id) %>%
  arrange(desc(logFC.aml)) %>% 
  column_to_rownames("Hugo_Symbol")

pheatmap(logFC1_aml_lgg, cluster_row = T, cluster_cols = F)
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-2-3.png)

``` r
#Quality check venn diagram of overlapped regions between all the DE genes in aml and all the DE genes in lgg (we pulled out DE genes in AML, and DE genes in LGG and separately merged them together)
DE_IDH_aml <- read_excel("../../Results_edgeR/DE_IDH_aml.xlsx", 2)
DE_IDH_lgg <- read_excel("../../Results_edgeR/DE_IDH_lgg.xlsx", 2)

overlap_aml_lgg <- merge(DE_IDH_aml, DE_IDH_lgg,
                         by = c("Hugo_Symbol", "Entrez_Gene_Id"))

grid.newpage()
draw.pairwise.venn(area1 = nrow(DE_IDH_aml), area2 = nrow(DE_IDH_lgg), 
                   cross.area = nrow(overlap_aml_lgg),
                   category = c("AML", "LGG"),
                   fill = c("blue", "red"),
                   alpha = rep(0.5, 1),
                   cat.cex = 2, cat.dist = 0, cex = 3)
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-2-4.png)

    ## (polygon[GRID.polygon.107], polygon[GRID.polygon.108], text[GRID.text.109], text[GRID.text.110], text[GRID.text.111], text[GRID.text.112], text[GRID.text.113])

``` r
#yes, all the genes that were claimed to overlap, does indeed overlap both ways
```

There's a specific region that is heavily upregulated in both and heavily downregulated in both.

Let's look into these specific regions.

``` r
#heatmap of upregulated genes
pheatmap(up_gene_both)
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-4-1.png)

``` r
#heatmap of downregulated genes
pheatmap(down_gene_both)
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-4-2.png)

``` r
#heatmap of genes upregulated in aml but downregulated in lgg
pheatmap(up_aml_down_lgg)
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-4-3.png)

``` r
#heatmap of genes downregulated in aml but upregulated in lgg
pheatmap(up_lgg_down_aml)
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-4-4.png)

``` r
#looking at all of these together
quadrant.labels <- data.frame(
  xpos = c(-Inf, -Inf, Inf, Inf),
  ypos = c(-Inf, Inf, -Inf, Inf), 
  hjustvar = c(0,0,1,1),
  vjustvar = c(-1,1,-1,1),
  labelText = c("Both down", "Up LGG only", "Up AML only", "Both up"),
  colorText = c("red","blue","green","purple")
)

#this is a graph that plots out all four of these quadrants out. It shows how you can divide out common differentially expresse genes in both AML and LGG:
ggplot(logFC1_aml_lgg, aes(x = logFC.aml, y = logFC.lgg)) + geom_point() +
  geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
  geom_text(data = quadrant.labels, aes(x = xpos, y = ypos, hjust = hjustvar,
                                        vjust = vjustvar, label = labelText, color = colorText),
            show.legend = F, size = 8)
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-4-5.png)

Issue: there are some abs(logFC.aml) &lt; 1 when they both should be abs(logFC) &gt; 1 for the overlaps

``` r
overlap_aml_lgg.absFC.filtered <- overlap_aml_lgg %>% 
  dplyr::filter(abs(logFC.x) > 1, abs(logFC.y) > 1)
colnames(overlap_aml_lgg.absFC.filtered) <- 
  c("Hugo_Symbol", "Entrez_Gene_Id", 
    "logFC.aml", "logCPM.aml", "LR.aml", "PValue.aml", "FDR.aml",
    "logFC.lgg", "logCPM.lgg", "LR.lgg", "PValue.lgg", "FDR.lgg")

#Trying to look at the distribution of FC in aml against FDR in aml:

ggplot(overlap_aml_lgg.absFC.filtered, aes(x = logFC.aml, y = FDR.aml)) + geom_point()
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-5-1.png)

``` r
#looks good

#ggplot to see the newly changed scatter plot with the four quadrants:

ggplot(overlap_aml_lgg.absFC.filtered, aes(x = logFC.aml, y = logFC.lgg)) + geom_point() +
  geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
  geom_text(data = quadrant.labels, aes(x = xpos, y = ypos, hjust = hjustvar,
                                        vjust = vjustvar, label = labelText, color = colorText),
            show.legend = F)
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-5-2.png)

``` r
upup <- overlap_aml_lgg.absFC.filtered %>% 
  dplyr::filter(logFC.aml > 1, logFC.lgg > 1)
downdown <- overlap_aml_lgg.absFC.filtered %>% 
  dplyr::filter(logFC.aml < -1, logFC.lgg < -1)
upaml.downlgg <- overlap_aml_lgg.absFC.filtered %>% 
  dplyr::filter(logFC.aml > 1, logFC.lgg < -1)
downaml.uplgg <- overlap_aml_lgg.absFC.filtered %>% 
  dplyr::filter(logFC.aml < -1, logFC.lgg > 1)
```

Let's look at genes unique to AML and LGG

Comparing DM genes (from LGG) to the quadrant of pulled down genes. These genes filtered out are genes that are differentially methylated (in LGG) AND differentially expressed in both. \*DM genes from AML were not significant, so that was not looked into.

``` r
DM_genes <- read.delim("../data/processed_data/lgg_DM_filtered_genes.csv", sep = ",")

DM_genes_DE_genes <- merge(overlap_aml_lgg.absFC.filtered, DM_genes, by.x = "Hugo_Symbol", by.y = "Hugo_Symbol")

ggplot(DM_genes_DE_genes, aes(x = logFC.aml, y = logFC.lgg)) + geom_point() + 
  geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + 
  geom_text(aes(label = Hugo_Symbol), data = subset(DM_genes_DE_genes, 
                                                    logFC.aml < -3 |
                                                      logFC.aml > 2 |
                                                      logFC.lgg < -3 |
                                                      logFC.lgg > 0))
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-7-1.png)

``` r
#genes that are very downreg in AML
DM_genes_DE_genes %>% dplyr::filter(logFC.aml < -5)
```

    ##   Hugo_Symbol Entrez_Gene_Id logFC.aml logCPM.aml   LR.aml   PValue.aml
    ## 1        LGSN          51557 -5.165751  0.7094902 35.89728 2.079985e-09
    ## 2        PDPN          10630 -8.531399  1.6709576 13.26632 2.702178e-04
    ##        FDR.aml logFC.lgg logCPM.lgg    LR.lgg    PValue.lgg       FDR.lgg
    ## 1 1.120156e-06 -1.422008  -2.661762  29.32522  6.119418e-08  2.347222e-07
    ## 2 7.713983e-03 -3.890078   5.405040 538.97084 3.157369e-119 1.806917e-116
    ##       logFC   AveExpr         t      P.Value    adj.P.Val        B
    ## 1 0.9499714  3.423683  6.222187 1.728260e-09 2.898194e-09 10.14158
    ## 2 3.8432725 -1.081812 13.009548 9.727932e-31 4.762443e-30 58.62442

``` r
#LGSN and PDPN

#genes that are very upregulated in AML
DM_genes_DE_genes %>% dplyr::filter(logFC.aml > 2.5)
```

    ##   Hugo_Symbol Entrez_Gene_Id logFC.aml logCPM.aml   LR.aml   PValue.aml
    ## 1       KCNJ6           3763  3.824893 -1.1457601 23.86457 1.033569e-06
    ## 2        LMO1           4004  3.392913 -1.4295403 32.94480 9.481303e-09
    ## 3      NKAIN1          79570  3.917264 -0.2139989 50.37757 1.268359e-12
    ## 4        NOS2           4843  3.124388 -1.7107545 43.12126 5.145017e-11
    ##        FDR.aml logFC.lgg logCPM.lgg    LR.lgg   PValue.lgg      FDR.lgg
    ## 1 1.363900e-04 -1.128380 -0.4411991  26.48100 2.661424e-07 9.493913e-07
    ## 2 3.855601e-06 -1.283855  2.2554671  37.45509 9.354214e-10 4.376662e-09
    ## 3 1.944102e-09  1.278979  4.6417055  52.13582 5.179155e-13 3.346402e-12
    ## 4 5.695534e-08 -2.279631  2.2543588 170.41774 5.996926e-39 1.992014e-37
    ##       logFC  AveExpr         t      P.Value    adj.P.Val        B
    ## 1 2.0396674 1.334540 10.639692 1.650278e-22 5.391072e-22 39.76989
    ## 2 0.7378896 3.719574  7.718251 1.960378e-13 4.027976e-13 19.07041
    ## 3 0.5833930 3.128217  8.331932 3.305326e-15 7.489144e-15 23.10207
    ## 4 2.0650833 1.734037 13.992751 2.768565e-34 1.594938e-33 66.76034

``` r
#KCNJ6, LMO1, NKAIN1, NOS2 

#genes that are very downreg in LGG
DM_genes_DE_genes %>% dplyr::filter(logFC.lgg < -5)
```

    ##   Hugo_Symbol Entrez_Gene_Id logFC.aml logCPM.aml   LR.aml   PValue.aml
    ## 1         LTF           4057  1.943996   5.608193 12.89423 3.295958e-04
    ## 2       PRAME          23532 -2.833314   5.072049 14.31925 1.542789e-04
    ## 3      SPAG17         200162 -2.317567   0.519975 15.92181 6.601359e-05
    ##       FDR.aml logFC.lgg logCPM.lgg   LR.lgg    PValue.lgg       FDR.lgg
    ## 1 0.008888781 -5.345928  5.6985967 248.8375  4.654624e-56  3.294421e-54
    ## 2 0.005140738 -6.804958  0.4697677 305.3692  2.228646e-68  2.399989e-66
    ## 3 0.002786837 -6.966415  0.8010058 623.9244 1.047645e-137 9.123623e-135
    ##      logFC    AveExpr         t      P.Value    adj.P.Val         B
    ## 1 2.349219 -0.4662977  7.694273 2.290474e-13 4.683428e-13 18.916920
    ## 2 1.010706  2.2870975  5.948489 7.847448e-09 1.273110e-08  8.662704
    ## 3 3.078427  0.7118536 13.562694 9.998065e-33 5.405052e-32 63.185536

``` r
#LTF, PRAME, SPAG17

#genes that are very upreg in LGG
DM_genes_DE_genes %>% dplyr::filter(logFC.lgg > 1.25)
```

    ##   Hugo_Symbol Entrez_Gene_Id logFC.aml logCPM.aml   LR.aml   PValue.aml
    ## 1       CCL21           6366 -1.927300 -2.6520412 10.07295 1.504618e-03
    ## 2       FGF17           8822  1.022670  1.5652860 10.69462 1.074473e-03
    ## 3      NKAIN1          79570  3.917264 -0.2139989 50.37757 1.268359e-12
    ## 4     PCDHGB5          56101  1.099182  1.3482710 14.08086 1.751163e-04
    ## 5         PGF           5228 -1.133870  0.5984545 11.54274 6.801420e-04
    ##        FDR.aml logFC.lgg logCPM.lgg   LR.lgg   PValue.lgg      FDR.lgg
    ## 1 2.630624e-02  1.840880 -0.7276075 10.05420 1.520008e-03 3.253101e-03
    ## 2 2.076619e-02  1.990868  1.4510731 52.93114 3.454486e-13 2.266405e-12
    ## 3 1.944102e-09  1.278979  4.6417055 52.13582 5.179155e-13 3.346402e-12
    ## 4 5.683008e-03  1.791580  4.8496418 20.26431 6.744699e-06 2.016363e-05
    ## 5 1.489287e-02  1.955851  5.0200640 71.39072 2.930476e-17 2.732655e-16
    ##       logFC    AveExpr        t      P.Value    adj.P.Val          B
    ## 1 0.6615348  1.3152713 4.425864 1.365428e-05 1.887416e-05  1.4351170
    ## 2 1.5400178 -0.3968148 6.889179 3.543901e-11 6.453117e-11 13.9532617
    ## 3 0.5833930  3.1282174 8.331932 3.305326e-15 7.489144e-15 23.1020672
    ## 4 0.7223204  1.3380114 4.024843 7.297854e-05 9.716591e-05 -0.1639332
    ## 5 0.1521558  4.9601830 2.426742 1.585004e-02 1.841038e-02 -5.1410446

``` r
#CCL21, FGF17, NKAIN1, PCDHGB5, PGF
```

``` r
#tmp data frame for DM and DE comparison
tmp_DEoverlap_quad <- overlap_aml_lgg.absFC.filtered

tmp_DMDE <- DM_genes_DE_genes

#DM
tmp_DEoverlap_quad$DM <- ifelse(tmp_DEoverlap_quad$Hugo_Symbol %in% tmp_DMDE$Hugo_Symbol, "yes", "no")


tmp_DEoverlap_quad$quadrant <- "BothUP"
tmp_DEoverlap_quad$quadrant <- 
  ifelse(tmp_DEoverlap_quad$logFC.aml < 0 & tmp_DEoverlap_quad$logFC.lgg < 0,
         "BothDOWN", tmp_DEoverlap_quad$quadrant)
tmp_DEoverlap_quad$quadrant <- 
  ifelse(tmp_DEoverlap_quad$logFC.aml < 0 & tmp_DEoverlap_quad$logFC.lgg > 0,
         "DownAMLUpLGG", tmp_DEoverlap_quad$quadrant)
tmp_DEoverlap_quad$quadrant <- 
  ifelse(tmp_DEoverlap_quad$logFC.aml > 0 & tmp_DEoverlap_quad$logFC.lgg < 0,
         "UpAMLDownLGG", tmp_DEoverlap_quad$quadrant)

tmp_DEoverlap_quad <- within(tmp_DEoverlap_quad,
                             quadrant <- factor(quadrant, 
                                                levels = names(sort(table(quadrant),
                                                                    decreasing = TRUE))))
#plot the number of genes that overlapped with DM genes in LGG:
ggplot(tmp_DEoverlap_quad, aes(x = quadrant, fill = DM)) + geom_bar() + coord_flip() +
  scale_fill_discrete(name = "Overlap with DM \n genes in LGG?")
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-8-1.png)

``` r
#x = aml; y = lgg #looking at all the genes (with no logFC cutoff)
ggplot(overlap_aml_lgg, aes(x = logFC.x, y = logFC.y)) + geom_point()
```

![](EdgeR_differential_expression_files/figure-markdown_github/unnamed-chunk-8-2.png)

``` r
tmp <- overlap_aml_lgg %>% dplyr::filter(logFC.y < 0)
```
