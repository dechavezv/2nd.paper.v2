#! /bin/bash

#$ -wd /u/scratch/d/dechavez/IberianChinese
#$ -l h_rt=32:00:00,h_data=12G,highp,h_vmem=60G
#$ -o /u/scratch/d/dechavez/IberianChinese/log/rmBad.out
#$ -e /u/scratch/d/dechavez/IberianChinese/log/rmBad.err
#$ -m abe
#$ -M dechavezv

#highmem

source /u/local/Modules/default/init/modules.sh
module load samtools

IN_DIR=/u/scratch/d/dechavez/IberianChinese
OUT_DIR=/u/scratch/d/dechavez/IberianChinese

samtools view -hb -f 2 -F 256 -q 30 ${IN_DIR}/${1} | samtools view -hb -F 1024 > ${OUT_DIR}/${1%.bam}_Filtered.bam
source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar

java -jar -Xmx12g -Djava.io.tmpdir=/u/scratch/d/dechavez/IberianChinese/temp ${PICARD} BuildBamIndex \
VALIDATION_STRINGENCY=LENIENT TMP_DIR=/u/scratch/d/dechavez/IberianChinese/temp \
I=${OUT_DIR}/${1%.bam}_Filtered.bam 
