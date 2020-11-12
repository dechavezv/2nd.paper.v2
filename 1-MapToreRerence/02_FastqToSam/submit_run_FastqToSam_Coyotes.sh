#! /bin/bash

#$ -wd /u/scratch/d/dechavez/BD
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/scratch/d/dechavez/BD/log/FastqToSam
#$ -e /u/scratch/d/dechavez/BD/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/02_FastqToSam/run_FastqToSam_Coyotes.sh

DIR=/u/scratch/d/dechavez/Coyotes

## ${QSUB} ${SCRIPT} ${DIR} Cla15379Quebec.fastq.gz Cla15379Quebec.bam Cla_1a Cla15379Quebec Lib1 C7424ACXX UCLA
## ${QSUB} ${SCRIPT} ${DIR} Cla1850Florida.fastq.gz Cla1850Florida.bam Cla_1a Cla2379Ohio Lib1 C7424ACXX UCLA
## ${QSUB} ${SCRIPT} ${DIR} Cla2379Ohio.fastq.gz Cla2379Ohio.bam Cla_1a Cla1850Florida Lib1 C7424ACXX UCLA
${QSUB} ${SCRIPT} ${DIR} ClaB16_Illinois.fastq.gz ClaB16_Illinois.bam Cla_1a ClaB16 Lib1 C7424ACXX UCLA
