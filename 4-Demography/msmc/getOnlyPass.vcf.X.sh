#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/SA.VCF
#$ -l h_rt=24:00:00,h_data=1G,arch=intel*
#$ -N OnlySNPs
#$ -o /u/home/d/dechavez/project-rwayne/SA.VCF/log/
#$ -e /u/home/d/dechavez/project-rwayne/SA.VCF/log/
#$ -m abe
#$ -M dechavezv

Direc=/u/home/d/dechavez/project-rwayne/SA.VCF
export tabix=/u/home/d/dechavez/tabix-0.2.6

cd ${Direc}

PREFIX=$1
i=X

zcat ${PREFIX}_chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz | \
grep -v "FAIL" | grep -v "WARN" | grep -vE '\./\.' | ${tabix}/bgzip -c \
> ${Direc}/OnlyPass/${PREFIX}_chr${i}_Annot_Mask_Filter_passingSNPs.vcf.gz

cd ${Direc}/OnlyPass

${tabix}/tabix -p ${PREFIX}_chr${i}_Annot_Mask_Filter_passingSNPs.vcf.gz

echo '************** Done getting sites with Good Quality from chr$i **********'
