#! /bin/bash
#$ -wd /u/scratch/d/dechavez/IndelReal
#$ -l highp,highmem,h_rt=24:00:00,h_data=20G,h_vmem=40G,arch=intel*
#$ -t 04-4:1
#$ -N HC_BD_38
#$ -o /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered/log/
#$ -e /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered

export BAM=$(ls bsve$(printf %02d $SGE_TASK_ID)_Aligned.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx20g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr38 \
-I ${BAM} \
-o /u/scratch/d/dechavez/BD/GVCFs/${ID}_chr38.g.vcf.gz
