#! /bin/bash

#$ -wd /u/scratch/d/dechavez/HKA/
#$ -l h_rt=14:00:00,h_data=1G
#$ -N SubRunHKA.BD.AltAllelMW.KirkAdvice
#$ -o /u/scratch/d/dechavez/HKA/log/
#$ -e /u/scratch/d/dechavez/HKA/log/
#$ -m abe
#$ -M dechavezv


SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/08-HKA-like-Test
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

${QSUB} ${SCRIPT_DIR}/calcualte.HKA.BD.KirkAdvice.sh
${QSUB} ${SCRIPT_DIR}/calcualte.HKA.BD.KirkAdvice.X.sh

sleep 15m

cd /u/scratch/d/dechavez/HKA/BD

echo '********** Getting the final table ***********'
echo -e 'chrom\tStarWind\tEndWind\tPolym\tDiverg\tHKAratio\tTotalSites\tGoodQsites\tSitesPolym\tPercGoodQ\tENSEMBL\tGene' > HKA.BD.AltAllelMW.July10.KirkAdvice.txt
for i in {01..38} X;do \
cat Genes_HKA_bsve_AltAllelMW_chr${i}_TrimAlt_Annot_Mask_Filter.HKA.KirkAdvice.txt | sort -k2,3 -h | uniq | perl -pe 's/\t\n/\tNA\n/g' >> HKA.BD.AltAllelMW.July10.KirkAdvice.txt;done

sleep 10m

rm Genes*
rm *HKA.txt
rm bsve_*
