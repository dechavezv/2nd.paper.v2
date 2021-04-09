#! /bin/bash

#$ -wd /u/scratch/d/dechavez/L.griseus.Psomangen/GVCFs
#$ -l h_rt=12:00:00,h_data=1G,arch=intel*,h_vmem=30G
#$ -N Hete.SA
#$ -o /u/scratch/d/dechavez/L.griseus.Psomangen/GVCFs/log/
#$ -e /u/scratch/d/dechavez/L.griseus.Psomangen/GVCFs/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load python/2.7

direc=/u/scratch/d/dechavez/L.griseus.Psomangen/GVCFs
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/Heterozygosity/WindowHet/SlidingWindowHet.py

cd ${direc}

IDX=chr$(printf %02d ${SGE_TASK_ID})
Sps=$1
VCF=${Sps}_${IDX}_TrimAlt_Annot_Mask_Filter.vcf.gz

python2.7 ${SCRIPT} ${VCF} 100000 100000 ${IDX}
