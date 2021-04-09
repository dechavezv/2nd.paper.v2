# Pipeline to get neutral regions to build neutral SFS

## 1. GetHiQualCoords_20200602.sh

Obtains the coordinates of high quality sites from the final VCF file out of the last step of the variant calling pipeline (WGSproc8). This bash script runs the script obtain_high_qual_coordinates.py that only uses sites that passed all filters of our variant calling pipeline (i.e. have PASS in the FILTER column), but also eliminates sites that do not have information in the INFO column (i.e. it shows only a dot "."). This happens because GATK variant filtration will annotate a site as PASS when there is no information in the INFO column. 

## 2. Identify_Neutral_Regions.sh

Uses the bed file containig the previously extracted high quality coordinates in step 1 to get the coordinates of putatively neutral regions that are 10 Kb apart from exons, are not in repetitive regions or CpG islands and do not match with highly conserved sequences (i.e. do not blast to zebra fish genome).

## 3. Extract_neutral_sites2vcf.sh 

Extracts the neutral high quality coordinates identified in step 2 into new vcf file that contains all neutral snps and invariant sites. This vcf file will be used as input to obtain only the variant sites (i.e. SNPs) to do the preview of the projection for the number of sites and individuals to project the folded SFS. This is done with the scripts in the SFS directory.
