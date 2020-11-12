#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/rails.project
#$ -l h_rt=64:00:00,h_data=15G,highp,h_vmem=50G
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/log/MarkIlAd.out
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/log/MarkIlAd.err
#$ -m abe
#$ -M dechavezv
#$ -N MrkIlAd

source /u/local/Modules/default/init/modules.sh
module load java

DIR=/u/home/d/dechavez/project-rwayne/rails.project
TEMP_DIR=/u/home/d/dechavez/project-rwayne/rails.project/temp
PICARD=/u/local/apps/picard-tools/current/picard.jar
OUT=/u/home/d/dechavez/project-rwayne/rails.project

cd $DIR

FILENAME=$1

java -Xmx15G -jar -Djava.io.tmpdir=$TEMP_DIR \
${PICARD} \
MarkIlluminaAdapters \
I=${DIR}/$FILENAME \
O=${OUT}/${FILENAME%_FastqToSam.bam}_MarkIlluminaAdapters.bam \
M=${OUT}/${FILENAME%_FastqToSam.bam}_MarkIlluminaAdapters.bam_metrics.txt \
TMP_DIR=$TEMP_DIR
