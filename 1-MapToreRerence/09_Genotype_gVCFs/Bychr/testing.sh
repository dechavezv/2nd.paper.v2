#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/gvcf
#$ -l highmem,highp,h_data=10G,h_rt=310:00:00,h_vmem=80G,arch=intel*
#$ -N GTgVCF
#$ -o /u/scratch/d/dechavez/rails.project/gvcf/log/chr.1.out
#$ -e /u/scratch/d/dechavez/rails.project/gvcf/log/chr.1.err
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

java -jar -Xmx10g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/chr_and_superScafolds/InaccesibleRail.chr.fa \
-allSites \
-L PseudoChr_1 \
$(for j in {22..24}; do echo "-V /u/home/d/dechavez/project-rwayne/rails.project/gvcf/${j}_LS*_chr1.g.vcf.gz "; done) \
-o /u/scratch/d/dechavez/readsRailsFulgent/JointVCF/LS_joint_chr1.vcf.gz
