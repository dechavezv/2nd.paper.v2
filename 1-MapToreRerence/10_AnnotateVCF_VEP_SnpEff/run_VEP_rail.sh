#! /bin/bash
#$ -wd /u/scratch/d/dechavez/rails.project/VCF/Joint
#$ -l h_rt=48:00:00,h_data=2G,highp
#$ -N RailsVEP
#$ -o /u/scratch/d/dechavez/rails.project/VCF/Joint/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/Joint/log/
#$ -m abe
#$ -M dechavezv
## #$ -t 1-35:1

source /u/local/Modules/default/init/modules.sh
module load perl

VEPDIR=/u/home/d/dechavez/project-rwayne/ensembl-tools-release-87/scripts/variant_effect_predictor
BGZIP=/u/home/d/dechavez/tabix-0.2.6/bgzip
TABIX=/u/home/d/dechavez/tabix-0.2.6/tabix

cd /u/scratch/d/dechavez/rails.project/VCF/Joint

#i=$(printf $SGE_TASK_ID)
#i=W
i=35
perl $VEPDIR/variant_effect_predictor.pl --dir $VEPDIR --cache --vcf --offline \
-i LS_joint_chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz -o STDOUT \
--stats_file LS_joint_chr${i}_TrimAlt_Annot_Mask_Filter_VEP_stats.html \
--sift b --species gallus_gallus --canonical --allow_non_variant --symbol --force_overwrite | \
sed 's/ /_/g' | $BGZIP > LS_joint_chr${i}_TrimAlt_Annot_Mask_Filter_VEP.vcf.gz

$TABIX -p vcf LS_joint_chr${i}_TrimAlt_Annot_Mask_Filter_VEP.vcf.gz
