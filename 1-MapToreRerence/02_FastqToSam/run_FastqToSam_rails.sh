#! /bin/bash
#$ -wd /u/scratch/d/dechavez/readsRailsFulgent
#$ -l highp,h_rt=64:00:00,h_data=7G,arch=intel*,h_vmem=34G
#$ -o /u/scratch/d/dechavez/readsRailsFulgent/log/fast2bam.out
#$ -e /u/scratch/d/dechavez/readsRailsFulgent/log/fast2bam.err
#$ -m abe
#$ -M dechavezv
#$ -N fast2bam

#highmem

# USAGE: qsub ./run_FastqToSam.sh [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar

DIR=${1}
cd ${DIR}

mkdir -p /u/scratch/d/dechavez/readsRailsFulgent/temp/${2%.*}
TEMP_DIR=/u/scratch/d/dechavez/readsRailsFulgent/temp/${2%.*}

java -Xmx7G -jar -Djava.io.tmpdir=${TEMP_DIR} ${PICARD} FastqToSam \
FASTQ=${DIR}/${2} \
FASTQ2=${DIR}/${3} \
OUTPUT=${DIR}/${4} \
READ_GROUP_NAME=${5} \
SAMPLE_NAME=${6} \
LIBRARY_NAME=${7} \
PLATFORM_UNIT=${8} \
PLATFORM=illumina \
SEQUENCING_CENTER=${9} \
TMP_DIR=${TEMP_DIR}
