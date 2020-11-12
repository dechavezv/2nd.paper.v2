#! /bin/bash
#$ -wd /u/scratch/d/dechavez/Ethiopian/VCF
#$ -l highp,h_vmem=34G,h_rt=24:00:00,h_data=7G,arch=intel*
#$ -N Eth
#$ -o /u/scratch/d/dechavez/Ethiopian/VCF
#$ -e /u/scratch/d/dechavez/Ethiopian/VCF
#$ -m abe
#$ -M dechavezv


#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/scratch/d/dechavez/Ethiopian/VCF

java -jar -Xmx7g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chrX \
-trimAlternates \
-V Csmi01_chrX.vcf.gz \
-o Csmi01_chrX_TrimAlt.vcf.gz

java -jar -Xmx7g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chrX \
-V Csmi01_chrX_TrimAlt.vcf.gz \
-o Csmi01_chrX_TrimAlt_Annot.vcf.gz 
