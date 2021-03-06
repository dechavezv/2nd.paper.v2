#! /bin/bash
#$ -wd /u/scratch/d/dechavez/readsRailsFulgent/JointVCF
#$ -l highp,h_vmem=74G,h_rt=280:00:00,h_data=10G,arch=intel*
#$ -N trim_annot
#$ -o /u/scratch/d/dechavez/readsRailsFulgent/JointVCF/log/
#$ -e /u/scratch/d/dechavez/readsRailsFulgent/JointVCF/log/
#$ -m abe
#$ -M dechavezv
#$ -t 3-34:1

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/chr_and_superScafolds/InaccesibleRail.chr.fa

cd /u/scratch/d/dechavez/readsRailsFulgent/JointVCF

java -jar -Xmx10g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-trimAlternates \
-L PseudoChr_$(printf "$SGE_TASK_ID") \
-V LS_joint_chr$(printf "$SGE_TASK_ID").vcf.gz \
-o LS_joint_chr$(printf "$SGE_TASK_ID")_TrimAlt.vcf.gz

java -jar -Xmx20g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L PseudoChr_$(printf "$SGE_TASK_ID") \
-V LS_joint_chr$(printf "$SGE_TASK_ID")_TrimAlt.vcf.gz \
-o LS_joint_chr$(printf "$SGE_TASK_ID")_TrimAlt_Annot.vcf.gz 
