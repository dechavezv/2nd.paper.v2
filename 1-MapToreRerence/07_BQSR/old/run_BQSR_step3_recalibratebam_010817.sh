#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/bams/
#$ -l h_rt=12:00:00,h_data=4G,highp
#$ -pe shared 12
#$ -N BQSR_s3_r1
#$ -o /u/scratch/j/jarobins/irnp/reports
#$ -e /u/scratch/j/jarobins/irnp/reports
#$ -m abe
#$ -M jarobins

# NOTE: Need to carefully manage disk space usage!!!

source /u/local/Modules/default/init/modules.sh
module load java

# Step 3: recalibrate BAM

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa
IN_BAM_DIR=/u/scratch/j/jarobins/irnp/bams/ReadsFiltered
OUT_BAM_DIR=/u/scratch/j/jarobins/irnp/bams/BQSR/recal1

cd ${IN_BAM_DIR}

IN_FILE=${1}

java -jar -Xmx42g -Djava.io.tmpdir=/u/scratch/j/jarobins/temp ${GATK} \
-T PrintReads \
-nct 12 \
-R ${REFERENCE} \
-I ${IN_BAM_DIR}/${IN_FILE} \
-o ${OUT_BAM_DIR}/${IN_FILE}_BQSR1_recal.bam \
-BQSR ${OUT_BAM_DIR}/${IN_FILE}_BQSR1_recal.table
