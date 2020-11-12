#! /bin/bash
#$ -wd /u/scratch/d/dechavez/IndelReal
#$ -l h_rt=42:00:00,h_data=22G,highp
#$ -N HC_Lculp_12
#$ -o /u/scratch/d/dechavez/IndelReal/log/
#$ -e /u/scratch/d/dechavez/IndelReal/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/d/dechavez/IndelReal

export BAM=Andean_Fox_merged_sortRG_MarkPCRDup_realign_fixmate_Filtered.bam
export ID=Lculp01

java -jar -Xmx16g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chrX \
-I ${BAM} \
-o /u/home/d/dechavez/project-rwayne/Lculp/GVCFs/${ID}_chrX.g.vcf.gz
