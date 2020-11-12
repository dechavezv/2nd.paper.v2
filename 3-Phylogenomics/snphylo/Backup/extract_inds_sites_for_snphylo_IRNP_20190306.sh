#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/irnp/new/vcfs/variants
#$ -l h_rt=24:00:00,h_data=2G
#$ -N getSNPs
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

VCFTOOLS=/u/home/j/jarobins/project-rwayne/utils/programs/vcftools/bin/vcftools
#BGZIP=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/bgzip
#TABIX=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/tabix

INDIR=/u/home/j/jarobins/project-rwayne/irnp/new/vcfs/variants
OUTDIR=/u/home/j/jarobins/project-rwayne/irnp/new/snphylo
FILE=${INDIR}/IRNP_44_joint_chr$(printf "%02d" ${SGE_TASK_ID})_TrimAlt_Annot_VEP_Masked_Filter_vars.vcf.gz
KEEP=${OUTDIR}/20canids.list
CHR=chr$(printf "%02d" ${SGE_TASK_ID})
OUT=${OUTDIR}/IRNP_44_joint_chr$(printf "%02d" ${SGE_TASK_ID})_TrimAlt_Annot_VEP_Masked_Filter_vars_20canids_PASS_polymorphic

${VCFTOOLS} \
--gzvcf ${FILE} \
--keep ${KEEP} \
--chr ${CHR} \
--out ${OUT} \
--recode \
--remove-indels \
--remove-filtered-all \
--non-ref-ac-any 1 \
--min-alleles 2 \
--max-alleles 2 \
--mac 1
