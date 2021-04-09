#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris
#$ -l h_rt=24:00:00,h_data=1G,arch=intel*
#$ -N OnlySNPs
#$ -o /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris/log
#$ -e /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris/log
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

Direc=/u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris
export tabix=/u/home/d/dechavez/tabix-0.2.6

cd ${Direc}

PREFIX=$1
i=$(printf %02d $SGE_TASK_ID)

zcat ${PREFIX}.chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz | \
grep -v "FAIL" | grep -v "WARN" | grep -vE '\./\.' | ${tabix}/bgzip -c \
> ${Direc}/onlyPass/${PREFIX}_chr${i}_Annot_Mask_Filter_passingSNPs.vcf.gz

## sleep 15m

cd ${Direc}/onlyPass

/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf ${PREFIX}_chr${i}_Annot_Mask_Filter_passingSNPs.vcf.gz

echo '************** Done getting sites with Good Quality from chr$i **********'
