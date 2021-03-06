#! /bin/bash

#$ -wd /u/scratch/d/dechavez/Croatian
#$ -l highmem_forced=TRUE,highp,h_rt=24:00:00,h_data=6G,h_vmem=60G
#$ -o /u/scratch/d/dechavez/Croatian/log/rmBad.out
#$ -e /u/scratch/d/dechavez/Croatian/log/rmBad.err
#$ -m abe
#$ -M dechavezv

#highmem

source /u/local/Modules/default/init/modules.sh
module load samtools

IN_DIR=/u/scratch/d/dechavez/Croatian
OUT_DIR=/u/scratch/d/dechavez/Croatian

samtools view -hb -f 2 -F 256 -q 30 ${IN_DIR}/${1} | samtools view -hb -F 1024 > ${OUT_DIR}/${1%.bam}_Filtered.bam
source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar

java -jar -Xmx6g -Djava.io.tmpdir=/u/scratch/d/dechavez/Croatian/temp ${PICARD} BuildBamIndex \
VALIDATION_STRINGENCY=LENIENT TMP_DIR=/u/scratch/d/dechavez/Croatian/temp \
I=${OUT_DIR}/${1%.bam}_Filtered.bam 
