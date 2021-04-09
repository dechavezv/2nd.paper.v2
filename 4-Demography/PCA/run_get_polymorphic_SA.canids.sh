#! /bin/bash
#$ -wd  /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris
#$ -l h_rt=24:00:00,h_data=5G,arch=intel*
#$ -N OnlySNPs
#$ -o /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris/log
#$ -e /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris/log
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

#echo "Task id is $(printf %02d $SGE_TASK_ID)"

source /u/local/Modules/default/init/modules.sh
module load python

Direc=/u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris/onlyPass

cd /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris

##PREFIX=$1

i=$(printf %02d $SGE_TASK_ID)

BGZIP=/u/home/d/dechavez/tabix-0.2.6/bgzip
TABIX=/u/home/d/dechavez/tabix-0.2.6/tabix

INFILE=SA.2021.gris.chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz
OUTFILE=${INFILE%.vcf.gz}_passingSNPs.vcf.gz

zcat ${INFILE} | head -1000 | grep "^#" > ${INFILE}_head
zcat ${INFILE} | grep -v "^#" | grep -v "FAIL" | \
grep -v "WARN" | grep -vE '\./\.' | grep -v "NO_VARIATION" | grep -v "NON_REF" | \
grep -v "AF=0.0;" | grep -v "AF=0.00;" | grep -v "AF=1.0" | \
cat ${INFILE}_head - | ${BGZIP} > ${Direc}/${OUTFILE}


## grep "/1:" | grep -v "AF=1" 
cd ${Direc}

${TABIX} -p vcf ${OUTFILE}

## vcf=SA_chr${i}_TrimAlt_Annot_Mask_Filter_passingSNPs.vcf

#/u/home/d/dechavez/tabix-0.2.6/bgzip -c ${vcf} > ${vcf}.gz
#/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf ${vcf}.gz

#rm SA_chr${i}_TrimAlt_Annot_Mask_Filter_passingSNPs.vcf

#grep -v "^#" | grep -v "FAIL" | grep -v "WARN" | grep -v "NO_VARIATION" | grep -v "NON_REF" | \
#grep -v "AF=0.0;" | grep -v "AF=0.00;" | grep -v "AF=1.0" > LS_joint_chr$(printf $SGE_TASK_ID)_Annot_Mask_Filter_passingSNPs.vcf

#zcat ${PREFIX}_AmiDgr_chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz | \
#grep -v "FAIL" | grep -v "WARN" | grep -vE '\./\.' \ > ${Direc}/${PREFIX}_AmiDgr_chr${i}_Annot_Mask_Filter_passingSNPs.vcf
