# install.packages("remotes")  

# Install and load gtexr 
if (!requireNamespace("gtexr", quietly = TRUE)) {
  remotes::install_github("ropensci/gtexr")
}
library(gtexr)




#--------------------------------
# Clean environment
#--------------------------------
rm(list = ls())            # removes all objects
graphics.off()             # closes any open plots
cat("\014")                # clears the console
# ---------------------------
setwd("...")




#--------------------------------
# Define gene
#--------------------------------
# gencode_id <- "ENSG00000110680.12"  # CALCA / CALCB locus
# gencode_id <- "ENSG00000175868.13"  # CALCB / CALCB locus
gencode_id <- "ENSG00000064989.12"  # CALCRL / CALCB locus


#--------------------------------
# Query GTEx v8 for significant eQTLs (all tissues)
# GTEx tissue-specific significance thresholds, based on a false discovery rate (FDR) threshold of ≤5%
#--------------------------------
eqtls <- get_significant_single_tissue_eqtls(
  gencodeIds = gencode_id,
  tissueSiteDetailIds = NULL,
  datasetId = "gtex_v8",
  itemsPerPage = 100000  # large number to capture all
)


# Inspect columns
print(colnames(eqtls))




#--------------------------------
# Save 
#--------------------------------
# write.csv(eqtls, "data/CALCA_eQTLs_GTEx_v8.csv", row.names = FALSE)
# write.csv(eqtls, "data/CALCB_eQTLs_GTEx_v8.csv", row.names = FALSE)
write.csv(eqtls, "data/CALCRL_eQTLs_GTEx_v8.csv", row.names = FALSE)
message("Done: ", nrow(eqtls), " eQTLs saved.")

