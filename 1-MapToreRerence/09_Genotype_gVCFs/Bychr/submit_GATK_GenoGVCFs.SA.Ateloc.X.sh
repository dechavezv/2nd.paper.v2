#! /bin/bash

#$ -wd /u/scratch/d/dechavez/QB3ateloc
#$ -l highmem_forced=TRUE,highp,h_data=12G,h_rt=49:00:00,h_vmem=50G,arch=intel*
#$ -t 01-1:1
#$ -N GTgVCF
#$ -o /u/scratch/d/dechavez/QB3ateloc/log/
#$ -e /u/scratch/d/dechavez/QB3ateloc/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx12g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chrX \
-V /u/scratch/d/dechavez/QB3ateloc/$(printf "%02d" "$SGE_TASK_ID")_AmiDgr_chrX.g.vcf.gz \
-o /u/scratch/d/dechavez/QB3ateloc/$(printf "%02d" "$SGE_TASK_ID")_AmiDgr_chrX.vcf.gz
