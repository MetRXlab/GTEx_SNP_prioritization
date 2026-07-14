# GTEx eQTL Analysis Pipeline

This repository contains the workflow used to retrieve, select, and characterize GTEx v8 eQTL variants for candidate genes **CALCA, CALCB, and CALCRL**.

The pipeline consists of three main steps:

---

## 1. GTEx eQTL Retrieval (R)

**File:**

```
01_download_gtex_eqtls.R
```
This script retrieves significant tissue-specific eQTL associations from the **GTEx v8 database** using the `gtexr` R package.

### Main steps:

- Queries GTEx v8 for significant single-tissue eQTLs
- Retrieves variant–gene associations for selected genes
- Exports GTEx eQTL results for downstream analysis

Genes analysed:

- CALCA
- CALCB
- CALCRL

Output:

```
data/
├── CALCA_eQTLs_GTEx_v8.csv
├── CALCB_eQTLs_GTEx_v8.csv
└── CALCRL_eQTLs_GTEx_v8.csv
```


---

## 2. SNP Selection and LD Clumping (Python)

**Notebook:**

```
02_GTEx_SNP_selection.ipynb
```



This notebook processes GTEx eQTL results and identifies independent regulatory variants.

### Main steps:

- Imports GTEx eQTL results generated from the R script
- Retrieves additional SNP–tissue associations from the GTEx API
- Filters variants by quality criteria:
  - removes ambiguous SNPs (A/T, T/A, C/G, G/C)
  - removes multi-allelic variants
- Aligns alleles according to GTEx normalized effect size (NES)
- Prepares input files for PLINK2
- Performs LD clumping by tissue
- Generates a Sankey plot showing:
  - Gene → Tissue → SNP relationships

Output:

```
data/clump_results_by_tissue/
└── clump_index_snps_MERGED.tsv

sankey_plot/
├── sankey_plot.html
└── sankey_plot.png
```

This file contains the independent SNPs used for downstream tissue-specific analyses.
The Sankey visualization provides an overview of how independent eQTL variants are distributed across tissues and their corresponding target genes.


---

## 3. Tissue-Specific eQTL Expression Profiles (Python)

**Notebook:**

```
03_GTEx_SNP_Tissue_Profile_UPSet.ipynb
```

This notebook defines the tissue-specific expression profile of the selected independent SNPs.

### Main steps:

- Imports LD-clumped SNPs
- Queries GTEx v8 for SNP–tissue associations
- Retrieves tissue-specific eQTL expression profiles
- Applies NES-based allele alignment
- Generates cleaned SNP–tissue datasets
- Prepares data for UpSet plot visualization

The analysis identifies:

- SNPs shared between tissues
- Tissue-specific regulatory variants
- Patterns of eQTL activity across tissues

Output:

```
data/gtex_output/
└── gtex_results_*_cleaned.csv
```

---

# Workflow Summary

```
GTEx gene identifiers
          |
          ↓
1. Retrieve GTEx eQTLs
   (R / gtexr)
          |
          ↓
2. Select independent SNPs
   (Python + PLINK2 LD clumping)
          |
          ↓
3. Define tissue-specific eQTL profiles
   (Python + GTEx API)
```

---

# Requirements

## R

Required package:

```r
install.packages("remotes")
remotes::install_github("ropensci/gtexr")
```

## Python

Required packages:

```
pandas
numpy
requests
plotly
statsmodels
```

## External tools

- GTEx v8 Portal API
- PLINK2

---

# Data Sources

- **GTEx Portal v8**  
  Tissue-specific gene expression and eQTL associations

- **PLINK2**  
  LD clumping and independent SNP selection

---

# Notes

The workflow was developed for **CALCA, CALCB, and CALCRL** but can be adapted t
