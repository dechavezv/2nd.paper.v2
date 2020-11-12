#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/VCF
#$ -l h_rt=12:00:00,h_data=6G,highp
#$ -N snprelate
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/VCF/log/
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/VCF/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load R/4.0.2

cd /u/home/d/dechavez/project-rwayne/rails.project/VCF

Rscript /u/home/d/dechavez/project-rwayne/2nd.paper/3-Phylogenomics/snphylo/convert_vcf_to_gds_rails.R

#R CMD BATCH /u/home/d/dechavez/project-rwayne/2nd.paper/3-Phylogenomics/snphylo/convert_vcf_to_gds_rails.R
