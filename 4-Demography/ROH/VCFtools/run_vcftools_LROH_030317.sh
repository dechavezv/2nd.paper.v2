#! /bin/bash
#$ -wd /u/scratch/j/jarobins
#$ -l h_rt=24:00:00,h_data=3G,arch=intel*
#$ -N calcROH
#$ -o /u/home/j/jarobins/project-rwayne/reports
#$ -e /u/home/j/jarobins/project-rwayne/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-1:1

VCFTOOLS_DIR=/u/home/j/jarobins/project-rwayne/utils/programs/vcftools/bin/

cd /u/scratch/j/jarobins/irnp/vcfs/joint/annotated

zcat IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_VEP_Annot_Masked2.vcf.gz | grep -v "FAIL\|WARN\|CpG" | ${VCFTOOLS_DIR}/vcftools --vcf - --LROH --chr chr$(printf %02d $SGE_TASK_ID) --out IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_VEP_Annot_Masked2.vcf.gz
