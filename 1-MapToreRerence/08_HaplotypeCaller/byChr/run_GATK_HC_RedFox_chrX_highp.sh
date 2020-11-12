#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/red.fox
#$ -l h_rt=42:00:00,h_data=16G,highp,h_vmem=40G
#$ -N HC_Vulp_X
#$ -o /u/home/d/dechavez/project-rwayne/red.fox/log/
#$ -e /u/home/d/dechavez/project-rwayne/red.fox/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/red.fox

export BAM=SRR5328113_Aligned.MarkDup_Filtered.bam
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx16g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chrX \
-I ${BAM} \
-o /u/scratch/d/dechavez/red.fox/GVCF/${ID}_chrX.g.vcf.gz
