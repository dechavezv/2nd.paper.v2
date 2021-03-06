#! /bin/bash
#$ -wd /u/scratch/d/dechavez/IndelReal
#$ -l h_rt=30:00:00,h_data=22G,highp
#$ -t 01-3:1
#$ -N HC_BD_22
#$ -o /u/scratch/d/dechavez/IndelReal/log/reports
#$ -e /u/scratch/d/dechavez/IndelReal/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/d/dechavez/IndelReal

export BAM=$(ls bsve$(printf %02d $SGE_TASK_ID)_Aligned.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx16g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr22 \
-I ${BAM} \
-o /u/scratch/d/dechavez/BD/GVCFs/${ID}_chr22.g.vcf.gz
