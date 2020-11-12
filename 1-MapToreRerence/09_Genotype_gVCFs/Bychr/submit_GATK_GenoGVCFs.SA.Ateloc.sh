#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/SA.VCF/Combined
#$ -l highp,h_data=7G,h_rt=49:00:00,h_vmem=50G,arch=intel*
#$ -t 1-2:1
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/log/
#$ -e /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx7g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
-V echo '/u/scratch/d/dechavez/QB3ateloc/*_chr$(printf "%02d" "$SGE_TASK_ID").g.vcf.gz' \
-o /u/scratch/d/dechavez/QB3ateloc/SA_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz
