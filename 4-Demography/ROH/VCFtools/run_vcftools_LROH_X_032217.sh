#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/irnp/vcfs
#$ -l h_rt=24:00:00,h_data=3G,arch=intel*
#$ -N calcROH
#$ -o /u/home/j/jarobins/project-rwayne/reports
#$ -e /u/home/j/jarobins/project-rwayne/reports
#$ -m abe
#$ -M jarobins

VCFTOOLS_DIR=/u/home/j/jarobins/project-rwayne/utils/programs/vcftools/bin/

cd /u/home/j/jarobins/project-rwayne/irnp/vcfs

zcat IRNP_35_joint_chr39_X_TrimAlt_VEP_Annot_Masked2.vcf.gz | grep -v "FAIL\|WARN\|CpG" | ${VCFTOOLS_DIR}/vcftools --vcf - --LROH --chr chrX --out IRNP_35_joint_chr39_X_TrimAlt_VEP_Annot_Masked2.vcf.gz
