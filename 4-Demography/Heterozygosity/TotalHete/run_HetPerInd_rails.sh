#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/VCF/Joint
#$ -l h_rt=24:00:00,h_data=1G,arch=intel*
#$ -N railstotHet
#$ -o /u/scratch/d/dechavez/rails.project/VCF/Joint/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/Joint/log/
#$ -m abe
#$ -M dechavezv
#$ -t 3-35:1

# Usage: qsub run_HetPerInd_SA.sh

source /u/local/Modules/default/init/modules.sh
module load python

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/Heterozygosity/TotalHete

Direc=/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/Chr_Joint/2021.31Genomes

cd ${Direc}

i=$(printf $SGE_TASK_ID)

python ${SCRIPTDIR}/HetPerInd_SA.py LS_joint_chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz ${i}

#use the following for scafolds
#for i in {01..8}; do (python ${SCRIPTDIR}/HetPerInd_SA.py Reheader_${i}_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.vcf.gz);done

