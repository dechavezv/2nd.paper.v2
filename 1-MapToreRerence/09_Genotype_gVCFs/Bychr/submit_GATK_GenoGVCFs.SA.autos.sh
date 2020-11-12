#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/GVCF/
#$ -l highp,h_data=25G,h_rt=43:00:00,h_vmem=70G
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/GVCF/log/
#$ -e /u/home/d/dechavez/project-rwayne/GVCF/log/
#$ -m abe
#$ -M dechavezv
#$ -t 28-28:1

source /u/local/Modules/default/init/modules.sh
module load java

export Sps=/u/home/d/dechavez/project-rwayne/GVCF/Sps.txt

i=$(printf "%02d" "$SGE_TASK_ID")
#i=X

java -jar -Xmx25g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chr${i} \
$(for line in $(cat $Sps); do echo "-V /u/home/d/dechavez/project-rwayne/GVCF/${line}_chr${i}.g.vcf.gz "; done) \
-o /u/scratch/d/dechavez/SA.VCF/SA_chr${i}.vcf.gz
