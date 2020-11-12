#! /bin/bash

#$ -l highmem,highp,h_rt=23:00:00,h_vmem=40G,h_data=21G,arch=intel*
#$ -o /u/home/d/dechavez/project-rwayne/Coyote/log/
#$ -e /u/home/d/dechavez/project-rwayne/Coyote/log/
#$ -m abe
#$ -M dechavezv
#$ -N fq2sam

# USAGE: qsub ./run_FastqToSam.sh [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar

Seq=/u/home/d/dechavez/project-rwayne/Coyote
DIR=${1}
cd ${DIR}

mkdir ${DIR}/temp/${2%.*}
TEMP_DIR=${DIR}/temp/${2%.*}

java -Xmx21G -jar -Djava.io.tmpdir=${TEMP_DIR} ${PICARD} FastqToSam \
FASTQ=${Seq}/${2} \
OUTPUT=${DIR}/${3} \
READ_GROUP_NAME=${4} \
SAMPLE_NAME=${5} \
LIBRARY_NAME=${6} \
PLATFORM_UNIT=${7} \
PLATFORM=illumina \
SEQUENCING_CENTER=${8} \
TMP_DIR=${TEMP_DIR}
