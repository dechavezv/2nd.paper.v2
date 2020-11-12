#! /bin/bash
#$ -wd /u/scratch/d/dechavez/SA.VCF
#$ -l h_rt=24:00:00,h_data=2G
#$ -N vcf2table
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load python

cd /u/scratch/d/dechavez/SA.VCF

python /u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/DeltVariation/vcf2table.SA.py SA_chr$(printf %02d ${SGE_TASK_ID})_TrimAlt_Annot_Mask_Filter_VEP.vcf.gz
