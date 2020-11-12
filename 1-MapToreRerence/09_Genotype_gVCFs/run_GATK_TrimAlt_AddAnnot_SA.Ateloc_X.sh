#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/SA.VCF
#$ -l highp,h_vmem=64G,h_rt=24:00:00,h_data=7G,arch=intel*
#$ -N trim_annot
#$ -o /u/home/d/dechavez/project-rwayne/SA.VCF/
#$ -e /u/home/d/dechavez/project-rwayne/SA.VCF/
#$ -m abe
#$ -M dechavezv
#$ -t 1-4:1

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/scratch/d/dechavez/QB3ateloc

java -jar -Xmx7g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chrX \
-trimAlternates \
-V $(printf "%02d" "$SGE_TASK_ID")_AmiDgr_chrX.vcf.gz \
-o $(printf "%02d" "$SGE_TASK_ID")_AmiDgr_chrX_TrimAlt.vcf.gz

java -jar -Xmx17g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chrX \
-V $(printf "%02d" "$SGE_TASK_ID")_AmiDgr_chrX_TrimAlt.vcf.gz \
-o $(printf "%02d" "$SGE_TASK_ID")_AmiDgr_chrX_TrimAlt_Annot.vcf.gz 
