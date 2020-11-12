#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/irnp/new/snphylo
#$ -l h_rt=12:00:00,h_data=16G
#$ -N snprelate
#$ -o /u/home/j/jarobins/project-rwayne/irnp/SNPRelate
#$ -e /u/home/j/jarobins/project-rwayne/irnp/SNPRelate
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load R/3.2.3

cd /u/home/j/jarobins/project-rwayne/irnp/new/snphylo

R CMD BATCH /u/home/j/jarobins/project-rwayne/utils/scripts/snphylo/convert_vcf_to_gds_20190308.R
