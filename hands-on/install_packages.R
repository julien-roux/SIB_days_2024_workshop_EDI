####  Installing packages for SIB days workshop 2024 ####
# "Incorporating biological sex as a variable in the design and analysis of biomedical research experiments"
# Required for script "hands_on_limma_advanced.qmd"
# Author: Leonore Wigger

# Packages from CRAN
pkg.cran <- c("here", "stringi", "ggplot2", "dplyr", "tidyverse", "RColorBrewer", "devtools")
pkg.cran.new <- pkg.cran[!(pkg.cran %in% installed.packages()[,"Package"])]
if(length(pkg.cran.new) > 0) {install.packages(pkg.cran.new)}


# Packages from Bioconductor
pkg.bioc <- c("DESeq2", "edgeR", "SummarizedExperiment", "scater", "recount3", "org.Mm.eg.db", "GO.db")
pkg.bioc.new <- pkg.bioc[!(pkg.bioc %in% installed.packages()[,"Package"])]
if(length(pkg.bioc.new) > 0) {

   BioC_version_Rdependencies <- read.table(header = TRUE, text = "
   R_Version R_release_date Bioconductor_Version
   4.4.2 (?) 3.19
   4.4.1 (June,2024) 3.19  
   4.4.0 (April,2024) 3.19
   4.3.3 (February,2024) 3.18
   4.3.2 (October,2023) 3.18
   4.3.1 (June,2023) 3.18 
   4.3.0 (April,2023) 3.17
   ", colClasses="character")

   
   myRversion <- paste(R.Version()$major, R.Version()$minor,sep=".")
   if (!myRversion %in% BioC_version_Rdependencies$R_Version) {
     warning("R version is too old. Packages cannot be installed. Requirement: R version >= 4.3.0. ", call.=FALSE)
   }
   
   if (!require("BiocManager", quietly = TRUE)) {
     BiocVersion <- as.character(subset(BioC_version_Rdependencies, R_Version==myRversion, select=Bioconductor_Version, drop=TRUE))
     install.packages("BiocManager", version=BiocVersion)
   } 
   myBiocVersion <- BiocManager::version()
   BiocManager::install(pkg.bioc.new, version=myBiocVersion, update=FALSE, ask=FALSE)
}

### NOTES:
# R releases with dates
# https://cran.r-project.org/bin/windows/base/old/
  # Bioconductor releases with dates
# https://www.bioconductor.org/about/release-announcements/