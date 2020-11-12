##### Load libraries

library(gdsfmt)
library(SNPRelate)

##### Set working directory

setwd("/u/home/j/jarobins/project-rwayne/irnp/new/snphylo")


##### Specify VCF filename

vcf.fn <- "IRNP_44_vars_20canids_PASS_polymorphic_autos.vcf"


##### Convert VCF to GDS format

snpgdsVCF2GDS(vcf.fn, "IRNP_44_vars_20canids_PASS_polymorphic_autos.gds", method="biallelic.only")
