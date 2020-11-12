#! /bin/bash
#$ -wd /u/scratch/d/dechavez/IndelReal
#$ -l h_rt=24:00:00,h_data=8G,h_vmem=30G,arch=intel*
#$ -N HC_Lculp_38
#$ -o /u/scratch/d/dechavez/IndelReal/log/
#$ -e /u/scratch/d/dechavez/IndelReal/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/d/dechavez/IndelReal

export BAM=Andean_Fox_merged_sortRG_MarkPCRDup_realign_fixmate_Filtered.bam
export ID=Lculp01

java -jar -Xmx8g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr38 \
-I ${BAM} \
-o /u/home/d/dechavez/project-rwayne/Lculp/GVCFs/${ID}_chr38.g.vcf.gz
