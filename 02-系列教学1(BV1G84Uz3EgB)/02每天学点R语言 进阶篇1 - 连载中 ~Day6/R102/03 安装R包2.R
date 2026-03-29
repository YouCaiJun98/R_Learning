library(org.Hs.eg.db)

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("org.Hs.eg.db")

library(org.Hs.eg.db)
