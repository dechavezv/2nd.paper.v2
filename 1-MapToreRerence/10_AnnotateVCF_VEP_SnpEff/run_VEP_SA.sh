#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/SA.VCF/Combined
#$ -l h_rt=68:00:00,h_data=5G,highp
#$ -N SAcanidVEP
#$ -o /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/log/reports
#$ -m abe
#$ -M dechavezv
#$ -t 29-38:1

source /u/local/Modules/default/init/modules.sh
module load perl

VEPDIR=/u/home/d/dechavez/project-rwayne/ensembl-tools-release-87/scripts/variant_effect_predictor
BGZIP=/u/home/d/dechavez/tabix-0.2.6/bgzip
TABIX=/u/home/d/dechavez/tabix-0.2.6/tabix
OUTPUT_DIR=/u/scratch/d/dechavez/SA.VCF

cd /u/home/d/dechavez/project-rwayne/SA.VCF/Combined

perl $VEPDIR/variant_effect_predictor.pl --dir $VEPDIR --cache --vcf --offline \
-i SA_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_Mask_Filter.vcf.gz -o STDOUT \
--stats_file SA_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_Mask_Filter_VEP_stats.html \
--sift b --species canis_familiaris --canonical --allow_non_variant --symbol --force_overwrite | \
sed 's/ /_/g' | $BGZIP > ${OUTPUT_DIR}/SA_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_Mask_Filter_VEP.vcf.gz

$TABIX -p vcf SA_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot_Mask_Filter_VEP.vcf.gz
