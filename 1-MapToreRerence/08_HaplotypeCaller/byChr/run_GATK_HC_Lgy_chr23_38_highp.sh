#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered
#$ -l h_rt=24:00:00,h_data=14G,arch=intel*,h_vmem=24G
#$ -t 01-1:1
#$ -N HC_Lgy_38
#$ -o /u/scratch/d/dechavez/BD/GVCFs/log/reports
#$ -e /u/scratch/d/dechavez/BD/GVCFs/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered

export BAM=$(ls Lgy$(printf %02d $SGE_TASK_ID)_Aligned.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx14g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr38 \
-I ${BAM} \
-o /u/home/d/dechavez/project-rwayne/Lvet/Lgy/GVCFs/${ID}_chr38.g.vcf.gz
