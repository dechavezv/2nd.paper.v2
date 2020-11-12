#! /bin/bash
#$ -wd /u/scratch/d/dechavez/QB3ateloc
#$ -l h_rt=24:00:00,h_data=16G,h_vmem=30G,arch=intel*
#$ -t 01-4:1
#$ -N HC_BD_38
#$ -o /u/scratch/d/dechavez/QB3ateloc/log/reports
#$ -e /u/scratch/d/dechavez/QB3ateloc/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/d/dechavez/QB3ateloc

export BAM=$(ls $(printf %02d $SGE_TASK_ID)_*_Aligned.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx16g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr38 \
-I ${BAM} \
-o ${ID}_chr38.g.vcf.gz
