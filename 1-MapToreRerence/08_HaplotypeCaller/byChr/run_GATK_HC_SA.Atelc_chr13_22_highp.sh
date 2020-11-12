#! /bin/bash
#$ -wd /u/scratch/d/dechavez/QB3ateloc
#$ -l h_rt=42:00:00,h_data=22G,highp,h_vmem=40G
#$ -t 01-2:1
#$ -N HC_BD_22
#$ -o /u/scratch/d/dechavez/QB3ateloc/log/reports
#$ -e /u/scratch/d/dechavez/QB3ateloc/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/d/dechavez/QB3ateloc

export BAM=$(ls $(printf %02d $SGE_TASK_ID)_*_Aligned.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx22g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr19 \
-I ${BAM} \
-o ${ID}_chr19.g.vcf.gz
