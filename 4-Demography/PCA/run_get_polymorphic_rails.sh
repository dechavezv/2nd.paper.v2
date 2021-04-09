#! /bin/bash
#$ -wd /u/scratch/d/dechavez/rails.project/MaskedRpeaWM.March.2021
#$ -l h_rt=24:00:00,h_data=1G,h_vmem=6G,arch=intel*
#$ -N OnlySNPs
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/Chr_Joint/2021.31Genomes/log/
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/Chr_Joint/2021.31Genomes/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-35:1

i=$(printf "$SGE_TASK_ID")

source /u/local/Modules/default/init/modules.sh
module load python

cd /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/Chr_Joint/2021.31Genomes

## zcat LS_joint_chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz \
## grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | \
## grep -v "AF=0.0;" | grep -v "AF=0.00;" | grep -v "AF=1.0" | grep -vE '\./\.' | \
## /u/home/d/dechavez/tabix-0.2.6/bgzip -c \
## > onlyPass/LS_joint_chr${i}_TrimAlt_Annot_Mask_Filter_passingSNPs.vcf.gz

vcf=LS_joint_chr${i}_TrimAlt_Annot_Mask_Filter_passingSNPs.vcf.gz

cd onlyPass

#/u/home/d/dechavez/tabix-0.2.6/bgzip -c ${vcf} > ${vcf}.gz
/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf ${vcf}

#rm ${vcf}


# polymorphic
#grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -v "NO_VARIATION" | grep -v "NON_REF" | \
#grep '1/1\|0/1' > /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/LS_joint_allchr_Annot_Mask_Filter_passingSNPs.Scaf.vcf

#Good Quality
# grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -vE '\./\.' \
# > /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/LS_joint_chr$(printf $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf
