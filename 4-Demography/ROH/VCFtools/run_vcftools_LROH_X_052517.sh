#! /bin/bash
#$ -wd /u/scratch2/j/jarobins/irnp/joint_vcfs
#$ -l h_rt=24:00:00,h_data=8G,arch=intel*
#$ -N calcROH
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins

VCFTOOLS_DIR=/u/home/j/jarobins/project-rwayne/utils/programs/vcftools/bin/

cd /u/scratch2/j/jarobins/irnp/joint_vcfs

zcat IRNP_43_joint_chrX_TrimAlt_Annot_VEP_Masked_Filter.vcf.gz | grep -v "FAIL\|WARN\|CpG" | ${VCFTOOLS_DIR}/vcftools --vcf - --LROH --chr chrX --out IRNP_43_joint_chrX_TrimAlt_Annot_VEP_Masked_Filter.vcf.gz
