#! /bin/bash
#$ -wd /u/scratch/d/dechavez/YNP_4Genomes
#$ -l h_rt=32:00:00,h_data=10G,highp,h_vmem=30G
#$ -t 2-2:1
#$ -N HC_BV_22
#$ -o /u/scratch/d/dechavez/YNP_4Genomes/log/reports
#$ -e /u/scratch/d/dechavez/YNP_4Genomes/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/d/dechavez/YNP_4Genomes

export BAM=$(ls $(printf %02d $SGE_TASK_ID)_Clup*Aligned.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx10g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr34 \
-I ${BAM} \
-o /u/home/d/dechavez/project-rwayne/Clup/GVCF/YNP_RS/${ID}_chr34.g.vcf.gz
