##### Load libraries

library(gdsfmt)
library(SNPRelate)

##### Set working directory

setwd("/u/home/d/dechavez/project-rwayne/rails.project/VCF")

##### Specify VCF filename

vcf.fn <- "Reheader_allchr_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.vcf"


##### Convert VCF to GDS format

snpgdsVCF2GDS(vcf.fn, "Reheader_allchr_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.gds", method="biallelic.only")
