<center> <h2 style="color:blue;">README</h1> </center>

## Purpose:

This README provides our important results and detailed descriptions of relevant figures. 

### 1. Background and Hypothesis

-   [IDH_TET](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/IDH_TET.png):
Visual schematic of the consequences of IDH mutations.

### 2. Principle Component and Clustering Analyses on Gene Expression

-   [Explore_PCA_LGG.png](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/Explore_PCA_LGG.png):
Samples were plotted on the first-two PCs. IDH-mutant and IDH-WT samples form two clear clusters for LGG.

-   [Explore_PCA_AML.png](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/Explore_PCA_AML.png):
Samples were plotted on the first-two PCs. IDH-mutant and IDH-WT samples appeared indistinguishable for AML.

-   [cluster_heatmap_cor_AML_exp.png](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/RNA_Expression_Analysis/cluster_heatmap_cor_AML_exp.png)
Sample-sample Spearman correlations based on global RNA expression were clustered using Euclidean distance. Clustering did not resolve patients into distinct groups by their IDH status.

-   [cluster_heatmap_cor_LGG_exp.png](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/RNA_Expression_Analysis/cluster_heatmap_cor_LGG_exp.png)
Clustering was performed on sample-sample Spearman correlations as was done for AML. There seems to be some clustering of patients based on their IDH status. 

### 3. Clustering Analysis on DNA Methylation

-   [cluster_heatmap_corr_AML.png](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/aml_cor_heatmap_meth.png):
clustering on sample-sample correlations in AML. Sample-sample Spearman correlations based on global DNA methylation were clustered using Euclidean distance. Clustering did not resolve patients into distinct groups by their IDH status. There appears to be two samples that were relatively less correlated with all other samples. 

-   [cluster_heatmap_corr_LGG.png](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/lgg_cor_heatmap_meth.png):
Clustering on sample-sample correlations in LGG. Clustering was performed on sample-sample Spearman correlations as was done for AML. With a few exceptions, IDH mutant and IDH wildtype patients grouped within their respective groups indicating an association of IDH mutations with DNA methylation, as expected. 

-   [cluster_heatmap_genes_AML.png]():
Clustering on the top 1000 variable genes in AML. No apparent pattern and lack of any clustering with respect to IDH status. 

-   [cluster_heatmap_genes_LGG.png]():
Clustering on the top 1000 variable genes in LGG. Patients were completely segregated into their respective groups defined by IDH status.

### 4. Correlation between RNA expression and DNA methylation

-   [corr_exp_meth_AML.png]():
Scatterplot showing the correlation between RNA expression and DNA methylation in AML. 

-   [corr_exp_meth_LGG.png]():
Scatterplot showing the correlation between RNA expression and DNA methylation in LGG. 

### 5. Overlap of Differentially Expressed Genes

-   [four_quadrant.png](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/four_quadrant.png):
Overlapping DE genes analyses. EdgeR produced a list of DE genes for both disease states using an adjusted p-value of 0.1 to capture more genes from the analysis. Since the genes of interest were common to both diseases, the chances of an independent false discovery in both DE gene sets became 0.01. From this cluster, further filtering was conducted to determine genes that had a |logFC| > 1. This geneset was then characterized depending on its expression pattern in AML and LGG: downregulated in both (orange), upregulated in both (green), up in LGG but down in AML (blue), and down in LGG but up in AML (red). Genes that overlapped with LGG-DM genes (squares) are also represented.

-   [DE_genes_overlaps.png](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/DE_genes_overlaps.png):
Overlapping DE genes analyses. EdgeR produced a list of DE genes for both disease states using an adjusted p-value of 0.1 to capture more genes from the analysis. Since the genes of interest were common to both diseases, the chances of an independent false discovery in both DE gene sets became 0.01. From this cluster, further filtering was conducted to determine genes that had a |logFC| > 1. This geneset was then characterized depending on its expression pattern in AML and LGG: downregulated in both (orange), upregulated in both (green), up in LGG but down in AML (blue), and down in LGG but up in AML (red). Genes that overlapped with LGG-DM genes (squares) are also represented.

### 6. DE Gene Function Analysis

-   [GO.enrichment.plot.AML.LGG.png](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/GO.enrichment.plot.AML.LGG.png):
GO term enrichment for the common DE genes shared between LGG and AML.
The top ten GOSeq-approximated overrepresented p-values were plotted for the DE gene sets illustrated in [DE_genes_overlaps.png](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/DE_genes_overlaps.png) (plot order corresponds to each quadrant). Absent bars refer to substantially unenriched GO terms. The enrichment analysis suggests very little functional overlap between LGG and AML. 

-   It is important to note that this analysis could be more comprehensive. Many databases associated with relevant R packages (such as GO.db) omit lesser quality annotations, and therefore, these annotation are not included in the downstream enrichment analysis. In order to assess potential it is important to examine an inferred gene function (through correlation with other GO terms, functional inference through protein-protein interactions, an analysis of sequence homology). In a future study these techniques, when applied in concert, may be extremely informative. While this analysis is corroborated by expression analysis, the resolution of functional results could certainly be more robust. 

-   [CytoscapeEnrichmentMap.AML.LGG.png](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/CytoscapeEnrichmentMap.AML.LGG.png):
Cytoscape network of mutually downregulated genes.
The network illustrates GO enrichment for downregulated genes shared among LGG and AML. Significantly enriched GO terms are highlighted in blue (LGG) and red (AML). There are no mutually enriched ontologies, in addition to no node connectivity between enriched LGG and AML functional clusters. When considering [GO.enrichment.plot.AML.LGG.png](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/GO.enrichment.plot.AML.LGG.png) and [CytoscapeEnrichmentMap.AML.LGG.png](https://github.com/STAT540-UBC/team_5mC-on-an-island/blob/master/Results/CytoscapeEnrichmentMap.AML.LGG.png) in concert, there appears to be no ontological similarity between LGG and AML.
