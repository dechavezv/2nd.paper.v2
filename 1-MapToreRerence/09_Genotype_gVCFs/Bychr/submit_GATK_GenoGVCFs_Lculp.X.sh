#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Lculp
#$ -l highp,h_data=20G,h_rt=33:00:00,h_vmem=30G
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/Lculp/log/
#$ -e /u/home/d/dechavez/project-rwayne/Lculp/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx20g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chrX \
$(echo "-V /u/home/d/dechavez/project-rwayne/Lculp/GVCFs/Lculp01_chrX.g.vcf.gz") \
-o /u/home/d/dechavez/project-rwayne/Lculp/VCF/Lculp01_chrX.vcf.gz
