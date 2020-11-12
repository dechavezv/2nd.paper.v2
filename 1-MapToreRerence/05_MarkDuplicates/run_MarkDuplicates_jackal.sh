#! /bin/bash

#$ -wd /u/scratch/d/dechavez/Jackal
#$ -l h_rt=17:00:00,h_data=25G,highp
#$ -o /u/scratch/d/dechavez/Jackal/log/mrkDup.out
#$ -e /u/scratch/d/dechavez/Jackal/log/mrkDup.err
#$ -m abe
#$ -M dechavezv

# USAGE: qsub -N MarkDup ./run_MarkDuplicates_20181109.sh 44_IRNP_ETH2_EW1_T279_HFCKNCCXY_1_Aligned.bam 44_IRNP_ETH2_EW1_T279_HFCKNCCXY_1_Aligned_MarkDuplicates.bam 2500

source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar
TEMP_DIR=/u/scratch/d/dechavez/rails.project/temp
BAM_DIR=/u/scratch/d/dechavez/Jackal

BAM1=$1
BAM_OUT=$2

OPT_DIST=$3

java -Xmx20G -Djava.io.tmpdir=$TEMP_DIR -jar $PICARD MarkDuplicates \
MAX_RECORDS_IN_RAM=150000 \
MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 \
INPUT=$BAM_DIR/$BAM1 \
OUTPUT=$BAM_DIR/$BAM_OUT \
METRICS_FILE=$BAM_DIR/${BAM_OUT}_metrics.txt \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=${OPT_DIST} \
CREATE_INDEX=true \
TMP_DIR=$TEMP_DIR
