#! /bin/bash
#$ -wd /u/scratch/d/dechavez/SA.VCF/
#$ -l highp,h_vmem=34G,h_rt=24:00:00,h_data=17G,arch=intel*
#$ -N trim_annot
#$ -o /u/scratch/d/dechavez/SA.VCF/log
#$ -e /u/scratch/d/dechavez/SA.VCF/log
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

cd /u/scratch/d/dechavez/SA.VCF/

java -jar -Xmx17g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-L chr$(printf "%02d" "$SGE_TASK_ID") \
-trimAlternates \
-V SA_chr$(printf "%02d" "$SGE_TASK_ID").vcf.gz \
-o /u/scratch/d/dechavez/SA.VCF/SA_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt.vcf.gz

java -jar -Xmx17g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L chr$(printf %02d $SGE_TASK_ID) \
-V /u/scratch/d/dechavez/SA.VCF/SA_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt.vcf.gz \
-o /u/scratch/d/dechavez/SA.VCF/SA_chr$(printf "%02d" "$SGE_TASK_ID")_TrimAlt_Annot.vcf.gz 
