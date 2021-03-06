#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/gvcf
#$ -l highp,h_data=14G,h_rt=300:00:00,h_vmem=90G,arch=intel*
#$ -t 1-1:1
#$ -N GTgVCF
#$ -o /u/scratch/d/dechavez/rails.project/gvcf/log/chr.1.out
#$ -e /u/scratch/d/dechavez/rails.project/gvcf/log/chr.1.err
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx8g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/chr_and_superScafolds/InaccesibleRail.chr.fa \
-allSites \
-L PseudoChr_$(printf "$SGE_TASK_ID") \
$(for j in {1..39}; do echo "-V /u/home/d/dechavez/project-rwayne/rails.project/gvcf/${j}_LS*_chr$(printf "$SGE_TASK_ID").g.vcf.gz "; done) \
-o /u/scratch/d/dechavez/readsRailsFulgent/JointVCF/LS_joint_chr$(printf "$SGE_TASK_ID").vcf.gz
